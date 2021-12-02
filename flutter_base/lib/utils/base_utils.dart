import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../flutter_base.dart';

class BaseUtils {
  static String formatDateFromApi(String inputtedDate) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);

      var outputFormat = DateFormat("dd MMM yyyy");
      return outputFormat.format(date1);
    } on Exception catch (e) {
      showLog("Error in formatDateFromApi parsing date ---> $e");
      return '';
    }
  }

  static String formatDateFromApi3(String inputtedDate) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);

      var outputFormat = DateFormat("EEE, dd MMM yyyy");
      return outputFormat.format(date1);
    } on Exception catch (e) {
      showLog("Error in formatDateFromApi3 parsing date ---> $e");
      return '';
    }
  }

  static String formatTimeFromApi(String inputtedDate) {
    try {
      var inputFormat = DateFormat("HH:mm:ss");
      var date1 = inputFormat.parse(inputtedDate);

      var outputFormat = DateFormat("hh:mm a");
      return outputFormat.format(date1);
    } on Exception catch (e) {
      showLog("Error in formatTimeFromApi parsing time ---> $e");
      return '';
    }
  }

  static String formatDateAPI(String inputtedDate) {
    try {
      var inputFormat = DateFormat("dd MMM yyyy");
      var outputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);

      return outputFormat.format(date1);
    } on Exception catch (e) {
      showLog("Error in formatDateAPI parsing date ---> $e");
      return '';
    }
  }

  static String currentDate() {
    try {
      var outputFormat = DateFormat("yyyy-MM-dd");
      return outputFormat.format(DateTime.now());
    } on Exception catch (e) {
      showLog("Error in currentDate parsing date ---> $e");
      return '';
    }
  }

  static String currentTime({bool? use12 = true}) {
    try {
      var outputFormat = DateFormat(use12! ? "hh:mm a" : "HH:mm");
      return outputFormat.format(DateTime.now());
    } on Exception catch (e) {
      showLog("Error in currentTime parsing date ---> $e");
      return '';
    }
  }

  static bool isTimeBeforeCurrent(String date, String time) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      var date1 = DateTime.now();
      var date2 = inputFormat.parse(date + " " + time);

      if (date2.isBefore(date1)) {
        return true;
      }

      return false;
    } on Exception catch (e) {
      showLog("Error isTimeBeforeCurrent in parsing time ---> $e");
      return false;
    }
  }

  static String formatDateOnly(String inputtedDate, String format) {
    try {
      var inputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);

      var outputFormat = DateFormat(format);
      return outputFormat.format(date1);
    } on Exception catch (e) {
      showLog("Error in formatDateOnly parsing date ---> $e");
      return '';
    }
  }

  static openMap(String lat, String lng) {
    final mapOptions = ['daddr=$lat,$lng', 'dir_action=navigate'].join('&');

    final mapUrl = 'https://www.google.com/maps?$mapOptions';
    launchUrlInBrowser(mapUrl);
  }

  static openEmail(String email) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: BaseUtils.encodeQueryParameters(
        <String, String>{
          'subject': 'Send us your query!',
          'body': '',
        },
      ),
    );
    launchUrlInBrowser(emailLaunchUri.toString());
  }

  static call(String phone) {
    launchUrlInBrowser("tel:${phone.removeSpaces()}");
  }

  static Future<bool> launchUrlInBrowser(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false, forceWebView: false);
        return true;
      } else {
        throw 'launchUrlInBrowser could not launch : $url';
      }
    } catch (e) {
      showLog('launchUrlInBrowser exception ====>>> $e');
      return false;
    }
  }

  static Future<void> launchSocial(String url) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched = await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      showLog("launchSocial exception =====>>> $e");
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future clearAppCacheData() async {
    var appDir = (await getTemporaryDirectory()).path;
    Directory(appDir).delete(recursive: true);
  }

  static Future clearPrefsExceptValues() async {
    final Set set = {};

    sharedPref.getKeys().toList().forEach((key) async {
      if (!set.contains(key)) await sharedPref.remove(key);
    });
  }

  static int calculateAge(String inputtedDate) {
    int age = 0;

    try {
      var inputFormat = DateFormat("yyyy-MM-dd");
      var date1 = inputFormat.parse(inputtedDate);
      var current = DateTime.now();

      age = (current.year - date1.year).ceilToDouble().toInt();
    } on Exception catch (e) {
      showLog('calculateAge exception ====>>> $e');
    }
    return age;
  }

  static String convertUTCToLocalTime(String inputtedDate) {
    try {
      // var dateUtc = inputtedDate+'.5Z';
      var dateUtc = inputtedDate;
      var strToDateTime = DateTime.parse(dateUtc.toString());
      final convertLocal = strToDateTime.toLocal();
      var newFormat = DateFormat("yy-MM-dd hh:mm:ss");
      String updatedDt = newFormat.format(convertLocal);
      return updatedDt;
    } on Exception catch (e) {
      showLog('convertUTCToLocalTime exception ====>>> $e');
      return '';
    }
  }

  /// Input 300 seconds output 05:00
  static String formatSecondsToTime(String inputtedDate) {
    try {
      var inputFormat = DateFormat("ss");
      var outputFormat = DateFormat("mm:ss");
      var date1 = inputFormat.parse(inputtedDate);
      return outputFormat.format(date1);
    } on Exception catch (e) {
      showLog('formatSecondsToTime exception ====>>> $e');
    }

    return '';
  }

  /// Input 300 seconds output 05:00
  static String formatSecondsToExpireTime(String inputtedDate) {
    try {
      var inputFormat = DateFormat("ss");
      var outputFormat = DateFormat("HH:mm:ss");
      var date1 = inputFormat.parse(inputtedDate);
      return outputFormat.format(date1);
    } on Exception catch (e) {
      showLog('formatSecondsToTime exception ====>>> $e');
    }

    return "00:00:00";
  }

  // static String formatTimeStamp(Timestamp timestamp) {
  //   try {
  //     var outputFormat = DateFormat("dd-MMM-yyyy HH:mm");
  //     // var outputFormat = DateFormat("HH:mm");
  //
  //     var date = DateTime.fromMillisecondsSinceEpoch(timestamp?.millisecondsSinceEpoch);
  //
  //     return outputFormat.format(date) ?? "";
  //   } on Exception catch (e) {
  //     showLog("Error in formatTimeStamp parsing date ---> $e");
  //     return "";
  //   }
  // }

  static Duration getDifference(DateTime from, DateTime to) {
    try {
      // showLog("getDifference from =====>>> $from");
      // showLog("getDifference to =====>>> $to");

      return from.difference(to);
    } catch (e) {
      showLog("getDifference exception =====>>> $e");
    }

    return Duration.zero;
  }

  static void openWhatsapp() async {
    try {
      const whatsapp = "+91987654321";
      const supportText = "I would like to get support for below concerns :- \n\n";

      if (Platform.isIOS) {
        final iOSUrl = "https://wa.me/$whatsapp?text=${Uri.encodeComponent(supportText)}";
        if (await canLaunch(iOSUrl)) {
          await launch(iOSUrl, forceSafariVC: false);
        } else {
          showSnackbar("Could not perform operation!");
        }
      } else {
        const androidUrl = "whatsapp://send?phone=$whatsapp&text=$supportText";
        if (await canLaunch(androidUrl)) {
          await launch(androidUrl);
        } else {
          showSnackbar("Could not perform operation!");
        }
      }
    } catch (e, stackTrace) {
      showSnackbar("Could not perform operation!");
      showLog("openWhatsapp exception =====>>> $e");
      showLog("openWhatsapp exception stackTrace =====>>> $stackTrace");
    }
  }

  Future<Uri> shortenUri(Uri uri, String bitlyToken) async {
    /// o_7mfemdu7p8
    final client = HttpClient();

    final endpoint = Uri.https('api-ssl.bitly.com', '/v4/shorten');

    final response = await client.postUrl(endpoint).then(
      (req) {
        req.headers
          ..set(HttpHeaders.contentTypeHeader, 'application/json')
          ..set(HttpHeaders.authorizationHeader, 'Bearer $bitlyToken');

        final body = {
          'long_url': uri.toString(),
          'domain': 'bit.ly',
        };
        final bodyBytes = utf8.encode(json.encode(body));
        req.add(bodyBytes);

        return req.close();
      },
    );

    final responseBody = await response.transform(utf8.decoder).join();
    final responseJson = json.decode(responseBody) as Map<String, dynamic>;
    return Uri.parse(responseJson['link']);
  }

  Future<Size> getImageSize(String uri) {
    final image = Image.network('https://bit.ly/3dAtFwy');
    final comp = Completer<ui.Image>();
    image.image
        .resolve(
          ImageConfiguration.empty,
        )
        .addListener(
          ImageStreamListener(
            (ImageInfo info, _) => comp.complete(info.image),
          ),
        );
    return comp.future.then(
      (image) => Size(
        image.width.toDouble(),
        image.height.toDouble(),
      ),
    );
  }

  /// Will be used to pick image using camera or gallery
  static Future<Map<String, dynamic>?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await BaseUtils.pickImageFromSource(source: source);

      if (pickedFile != null) {
        String fileName = "";

        if (source == ImageSource.camera) {
          final now = DateTime.now();
          fileName = "camera_image_${now.year}_${now.month}_${now.day}"
              "_${now.hour}_${now.minute}_${now.second}_${now.millisecondsSinceEpoch}.jpg";
        } else {
          fileName = pickedFile.path.substring(pickedFile.path.lastIndexOf("/")).substring(1);
        }
        return {
          'file': pickedFile,
          'file_name': fileName,
          'file_path': pickedFile.path,
        };
      }
    } catch (e, stackTrace) {
      showLog("pickImage exception =====>>> $e");
      showLog("pickImage exception stackTrace =====>>> $stackTrace");
    }
  }

  static Future<File?> pickImageFromSource({required ImageSource source}) async {
    final selectedImage = await ImagePicker().pickImage(source: source);
    return await compressImage(selectedImage);
  }

  static Future<File?> compressImage(XFile? imageToCompress) async {
    if (imageToCompress == null) {
      return null;
    }

    final actualFile = File(imageToCompress.path);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    im.Image? image = im.decodeImage(actualFile.readAsBytesSync());
    if (image == null) {
      return actualFile;
    }
    im.copyResize(image, width: 500, height: 500);

    final kFile = File('$path/temp_image_$rand.jpg')..writeAsBytesSync(im.encodeJpg(image, quality: 85));

    /*
    final now = DateTime.now();
    final dir = await getTemporaryDirectory();
    final targetPath =
        dir.absolute.path + "/temp_${now.millisecondsSinceEpoch}.jpg";
    final compressedFile = await testCompressAndGetFile(kFile, targetPath);
    return compressedFile ?? kFile;*/

    return kFile;
  }

  /*// 2. compress file and get file.
  static Future<File?> testCompressAndGetFile(
      File file, String targetPath) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 85,
    );
    return result;
  }*/

  /*
  static shareMe(BuildContext context, String title, String content) {
    // final RenderBox box = context.findRenderObject();
    // Share.share(
    //   title,
    //   subject: content,
    //   sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    // );
  }*/

  static getFileName(String path) {
    var fileName = (path.split('/').last);
    return fileName;
  }

  static String getMonthFromFullString(String month) {
    switch (month) {
      case "January":
        return "01";
      case "February":
        return "02";
      case "March":
        return "03";
      case "April":
        return "04";
      case "May":
        return "05";
      case "June":
        return "06";
      case "July":
        return "07";
      case "August":
        return "08";
      case "September":
        return "09";
      case "October":
        return "10";
      case "November":
        return "11";
      case "December":
        return "12";
      default:
        return "01";
    }
  }

  static String getDayFromInt(int month) {
    switch (month) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "Monday";
    }
  }

  static int getIntFromDay(String day) {
    switch (day) {
      case "Monday":
        return 1;
      case "Tuesday":
        return 2;
      case "Wednesday":
        return 3;
      case "Thursday":
        return 4;
      case "Friday":
        return 5;
      case "Saturday":
        return 6;
      case "Sunday":
        return 7;
      default:
        return 1;
    }
  }

  static void copyToClipboard(String? text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
