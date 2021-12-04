enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  adminOnlyOperations,
  undefined,
}

class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "error-invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "error-wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "error-user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "error-user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "error-too-many-requests":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "error-operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "error-email-already-in-user":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "admin-restricted-operation":
        status = AuthResultStatus.adminOnlyOperations;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static String generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = "The email has already been registered. Please login or reset your password.";
        break;
      case AuthResultStatus.adminOnlyOperations:
        errorMessage = "This action has been restricted to admin only.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}
