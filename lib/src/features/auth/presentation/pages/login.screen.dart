import 'package:fl_location/src/core/theme/dimens.dart';
import 'package:fl_location/src/features/auth/presentation/manager/login.manager.dart';
import 'package:fl_location/src/shared/widgets/box/sizedboxs.widget.dart';
import 'package:fl_location/src/shared/widgets/buttons/common_button.widget.dart';
import 'package:fl_location/src/shared/widgets/textfields/common_textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LoginManager>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.unitX8),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonTextfield(
                        controller: controller.emailController,
                        hint: 'Email',
                        validator: (val) => controller.validateEmailField(val),
                      ),
                      const SizedBoxHeightUnitX8(),
                      CommonTextfield(
                        controller: controller.passwordController,
                        secure: true,
                        hint: 'Password',
                        validator: (val) =>
                            controller.validatePasswordField(val),
                      ),
                      const SizedBoxHeightUnitX16(),
                      GetBuilder<LoginManager>(
                        builder: (_) => CommonButton(
                          onTap: () {
                            controller.login();
                          },
                          text: 'Login',
                          loading: controller.loadingLogin,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
