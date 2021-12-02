import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/base/app.dart';

import 'text_widget.dart';

class NoDataFound extends StatelessWidget {
  final String? msg;
  final double fontSize;
  final VoidCallback? onRetry;

  const NoDataFound({Key? key, this.msg, this.fontSize = 17.0, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Texts(
            msg ?? somethingWentWrongM,
            fontSize: fontSize,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          /*Center(
            child: Image.asset(
              Assets.imagesSplashLogo,
              height: screenWidth * 0.3,
              color: Palette.accentColor,
            ),
          ),
          const SizedBox(height: 30.0),
          Texts(
            msg ?? S.of(context).noDataFound,
            fontSize: fontSize,
            color: Palette.grey,
            fontFamily: semiBold,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null)
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: FilledButton(onTap: onRetry, text: S.of(context).retry.toUpperCase()),
            ),*/
        ],
      ),
    );
  }
}
