import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as v;

import 'globals.dart';

final notName = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
final alpha = RegExp(r"^[A-Za-z ]+$");
final alphanumeric = RegExp(r'^[a-zA-Z0-9 ]$');
final alphanumericAddress = RegExp(r'^(?!\s*$)[a-zA-Z0-9- ]+$');

final validator = Validator.instance;

class Validator {
  Validator._();

  static Validator get instance => Validator._();

  BuildContext? context;

  bool validateText(String name, {int? length}) {
    if (name == '') {
      return false;
    }

    if (length != null) {
      return name.length < length;
    } else {
      return true;
    }
  }

  String? validateNameString(String name) {
    if (name.isEmpty) return "Required";

    String pattern = r'[a-zA-Z]+';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name)) {
      return null;
    }

    return 'Invalid';
  }

  String? validatePassword(String value, {bool isLogin = false}) {
    String errorMsg = "Please enter password";
    // String errorMsg = "Please enter at least 6 char\'s to continue";

    if (value != "") {
      if (!RegExp(r'(^(?=.*[a-z]))').hasMatch(value)) {
        errorMsg = "One letter of the password should be capital.";
        return errorMsg;
      }

      if (!RegExp(r'(^(?=.*[A-Z]))').hasMatch(value)) {
        errorMsg = "One letter of the password should be lowercase.";
        return errorMsg;
      }

      if (!RegExp(r'(^(?=.*[0-9]))').hasMatch(value)) {
        errorMsg = "One letter of the password should be a number.";
        return errorMsg;
      }

      const validCharacters = r'(^(?=.*[_\-=@,\.;\`~#^*\(\)$&%=]))';

      if (!v.matches(value, validCharacters)) {
        errorMsg = "Password must contain a special character like (@, \$, !, &, etc).";
        return errorMsg;
      }

      if (value.length < 6) {
        errorMsg = "Password length must be greater than or equal to 6 char\'s.";
        return errorMsg;
      }

      return null;
    }
    return errorMsg;
  }

  bool validateConfirmPassword(String password, String value) {
    return value != ''
        ? (value != password)
            ? false
            : true
        : false;
  }

  bool phoneValidator(String phone) {
    String pattern = r'(^(?:[+0]9)?[0-9]{7,15}$)';
    RegExp regExp = RegExp(pattern);

    if (phone != '') {
      if (phone.isEmpty) {
        return false;
      } else if (!regExp.hasMatch(phone)) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  bool validateName(String name) {
    Pattern pattern = r'^[a-zA-Z][a-zA-Z\- ]*[a-zA-Z ]$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(name);
  }

  final falser = Future.value(false);
  final truer = Future.value(true);

  Future<bool> validateLoginForm(String email, String password) {
    if (email.isEmpty) {
      snackbar("Please enter email");
      return falser;
    }

    if (!v.isEmail(email)) {
      snackbar("Please enter valid email");
      return falser;
    }

    if (password.isEmpty) {
      snackbar("Please enter password");
      return falser;
    }

    if (validateText(password, length: 6)) {
      snackbar("Password length must be greater than or equal to 6 char's.");
      return falser;
    }

    return truer;
  }

  void snackbar(String message) {
    showSnackbar(message, context);
  }
}
