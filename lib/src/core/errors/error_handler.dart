import 'package:fl_location/src/core/errors/failures.dart';
import 'package:fl_location/src/shared/constant/firebase_error.dart';
import 'package:fl_location/src/shared/widgets/snackbars/app_snack_bar.widget.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static String getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;

      case NotFoundFailure:
        return (failure as NotFoundFailure).message;

      case BadRequestFailure:
        return (failure as BadRequestFailure).message;

      case BadGatewayFailure:
        return (failure as BadGatewayFailure).message;

      case MaintainServerFailure:
        return (failure as MaintainServerFailure).message;

      case InternalServerFailure:
        return (failure as InternalServerFailure).message;

      case AuthenticationFailure:
        return (failure as AuthenticationFailure).message;

      case AppFailure:
        return (failure as AppFailure).message;

      case FirebaseFailure:
        return firebaseAuthErrorMessage((failure as FirebaseFailure).code);

      case NetworkFailure:
        return 'Network Error';

      default:
        return 'Unknown Error';
    }
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    AppSnackBar.showErrorSnack(context: context, message: message);
  }

  static String firebaseAuthErrorMessage(String code) {
    switch (code) {
      case FirebaseError.userNotFound:
        return 'User Not Found';
      case FirebaseError.wrongPassword:
        return 'Wrong Password';
      case FirebaseError.internalError:
        return 'Internal Error';
      case FirebaseError.netwrokError:
        return 'Network Error';
      default:
        return 'Unknown Error';
    }
  }
}
