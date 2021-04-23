import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

import '../main.dart';

String parseError(dynamic error) {
  logger.e(error);
  String message;
  switch (error.runtimeType) {
    case FirebaseAuthException:
      message = AppStrings.userNotFound;
      break;
    default:
      message = error.toString();
  }
  return message;
}
