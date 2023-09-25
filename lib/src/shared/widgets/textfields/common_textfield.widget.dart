import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {
  const CommonTextfield({
    Key? key,
    required this.controller,
    this.validator,
    this.hint,  this.secure=false,
  }) : super(key: key);

  final Function? validator;
  final String? hint;
  final bool secure;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: secure,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: (value) => validator?.call(value),
    );
  }
}
