import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_base/base/app.dart';

class DeviceInfoService {
  late AndroidDeviceInfo androidInfo;
  late IosDeviceInfo iOSDeviceInfo;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<void> init() async {
    try {
      if (Platform.isAndroid) {
        androidInfo = await deviceInfoPlugin.androidInfo;
        isEmulator = !androidInfo.isPhysicalDevice!;
        sharedPref.setString(BaseKeys.deviceType, "android");
        sharedPref.setString(BaseKeys.deviceOS, (androidInfo.version.baseOS)!);
        return;
      }

      if (Platform.isIOS) {
        iOSDeviceInfo = await deviceInfoPlugin.iosInfo;
        isEmulator = !iOSDeviceInfo.isPhysicalDevice;
        sharedPref.setString(BaseKeys.deviceType, "apple");
        sharedPref.setString(BaseKeys.deviceOS, (iOSDeviceInfo.systemVersion)!);
        return;
      }
    } catch (e, stackTrace) {
      showLog("DeviceInfoService.init() exception =====>>> $e");
      showLog("DeviceInfoService.init() stackTrace =====>>> $stackTrace");
    }
  }
}
