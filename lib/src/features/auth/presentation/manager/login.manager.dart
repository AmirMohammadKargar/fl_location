import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_location/src/core/errors/error_handler.dart';
import 'package:fl_location/src/core/router/routes.dart';
import 'package:fl_location/src/core/store/store.dart';
import 'package:fl_location/src/features/auth/data/dtos/login_body.dto.dart';
import 'package:fl_location/src/features/auth/domain/usecases/auth.usecases.dart';
import 'package:fl_location/src/shared/extensions/email_validator.extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class LoginManager extends GetxController {
  final LoginUsecase _loginUsecase;
  LoginManager(this._loginUsecase);
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool _loadingLogin = false;

  bool get loadingLogin => _loadingLogin;

  String? validateEmailField(String? input) {
    if (input == null || !input.isValidEmail()) {
      return 'Not Valid Email!!';
    } else {
      return null;
    }
  }

  String? validatePasswordField(String input) {
    if (input.length < 8) {
      return 'Not Valid Password!!';
    } else {
      return null;
    }
  }

  Future<void> _loginFirebase() async {
    _loadingLogin = true;
    update();

    var body = LoginBodyDto(
        email: emailController.text, password: passwordController.text);
    var res = await _loginUsecase.call(LoginParams(body: body));

    _loadingLogin = false;
    update();

    res.fold(
        (failure) => ErrorHandler.showErrorSnackBar(
            Get.context!, ErrorHandler.getErrorMessage(failure)), (response) {
      _saveTokenAndUser(response);
      Get.offAllNamed(Routes.homePath);
    });
  }

  void _saveTokenAndUser(UserCredential userCredential) async {
    Store.token = await FirebaseAuth.instance.currentUser?.getIdToken();
    Store.user = userCredential.user;
  }

  void login() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      _loginFirebase();
    }
  }
}
