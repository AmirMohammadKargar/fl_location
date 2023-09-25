import 'package:fl_location/src/core/theme/dimens.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.loading = false,
  }) : super(key: key);

  final Function? onTap;
  final String text;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 140,
        height: Dimens.unitX12,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(Dimens.unitX3),
        ),
        child: Center(
          child: loading ? const CircularProgressIndicator() : Text(text),
        ),
      ),
    );
  }
}
