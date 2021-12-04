import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/base/app.dart';
import 'package:todo_flutter/app/router/routes.dart';
import 'package:todo_flutter/services/firebase_service.dart';

class AuthProvider extends ChangeNotifier {
  Future<dynamic> signInMeAnonymously() async {
    if (await isNetworkConnected()) {
      showLoader();
      final response = await firebaseService.signInAnonymously();

      if (response != null && response is User) {
        /// successful signup create document in firebase cloud firestore
        await firebaseService.updateDataOnFirestore(
          {
            "uid": response.uid,
            "email": response.email,
            "profileUrl": response.photoURL,
          },
        );
        hideLoader();
        navigationService.pushNamedAndRemoveUntil(Routes.homeScreen.value);
      } else {
        /// show error to user
        hideLoader();
        showSnackbar(response);
      }
    } else {
      noInternetBar();
    }
  }
}
