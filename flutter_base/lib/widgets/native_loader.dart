import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum LoaderPlatform { android, ios }

class NativeLoader extends StatelessWidget {
  final Color? valueColor;
  final LoaderPlatform? platform;

  const NativeLoader({
    Key? key,
    this.valueColor,
    this.platform,
  }) : super(key: key);

  const NativeLoader.android({
    Key? key,
    this.valueColor,
  })  : platform = LoaderPlatform.android,
        super(key: key);

  const NativeLoader.ios({
    Key? key,
    this.valueColor,
  })  : platform = LoaderPlatform.ios,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAndroid = Platform.isAndroid;

    /// null = PlatformSpecific meaning native loader will be shown
    if (platform != null) {
      isAndroid = platform == LoaderPlatform.android;
    }

    return Center(
      child: isAndroid
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(valueColor ?? Theme.of(context).primaryColor),
            )
          : const CupertinoActivityIndicator(),
    );
  }
}

class APILoader extends StatelessWidget {
  const APILoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NativeLoader.android();
  }
}
