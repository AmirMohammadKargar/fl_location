import 'package:fl_location/src/core/theme/color_pallete.dart';
import 'package:fl_location/src/core/theme/dimens.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static void showErrorSnack(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorPallete.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(Dimens.unitX4),
        dismissDirection: DismissDirection.horizontal,
        content: Text(
          message,
        ),
      ),
    );
  }

  static void showSuccessSnack(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorPallete.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(Dimens.unitX4),
        dismissDirection: DismissDirection.horizontal,
        content: Text(
          message,
        ),
      ),
    );
  }
}
