import 'package:evently_app/common/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  // User closed the Google account picker / popup: not an error to report
  static bool isGoogleCancellation(Object error) {
    if (error is GoogleSignInException) {
      return error.code == GoogleSignInExceptionCode.canceled ||
          error.code == GoogleSignInExceptionCode.interrupted;
    }
    if (error is FirebaseAuthException) {
      return error.code == 'popup-closed-by-user' ||
          error.code == 'cancelled-popup-request' ||
          error.code == 'web-context-canceled';
    }
    return false;
  }

  // Friendly messages based on the error code, without technical details
  static String messageFor(FirebaseAuthException e, AppStrings strings) {
    switch (e.code) {
      case 'invalid-email':
      case 'missing-email':
        return strings.invalidEmail;
      case 'missing-password':
        return strings.passwordRequired;
      case 'user-disabled':
        return strings.userDisabled;
      // Login: newer Firebase projects (email enumeration protection) send
      // 'invalid-credential' for both cases. We use one message on purpose so
      // the app never reveals whether an email is registered
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return strings.wrongCredentials;
      case 'email-already-in-use':
        return strings.emailInUse;
      case 'weak-password':
        return strings.weakPassword;
      case 'password-does-not-meet-requirements':
        return strings.passwordRequirements;
      case 'account-exists-with-different-credential':
        return strings.differentCredential;
      case 'operation-not-allowed':
        return strings.methodNotEnabled;
      case 'too-many-requests':
        return strings.tooManyRequests;
      case 'network-request-failed':
        return strings.networkError;
      default:
        return strings.genericError;
    }
  }
}
