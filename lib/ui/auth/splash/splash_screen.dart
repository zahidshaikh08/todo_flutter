import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:todo_flutter/app/router/routes.dart';
import 'package:todo_flutter/services/firebase_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      /// if user is not logged in previously
      /// goto login screen else goto home screen
      if (firebaseService.firebaseAuth.currentUser == null) {
        navigationService.pushNamedAndRemoveUntil(Routes.loginScreen.value);
      } else {
        navigationService.pushNamedAndRemoveUntil(Routes.homeScreen.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: Colors.white,
      isAppbar: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Welcome to ",
                    style: Texts.customTextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Clear",
                    style: Texts.customTextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Tap or swipe ",
                    style: Texts.customTextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "to begin.",
                    style: Texts.customTextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
