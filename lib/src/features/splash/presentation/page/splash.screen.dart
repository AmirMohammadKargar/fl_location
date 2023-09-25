import 'package:fl_location/src/features/splash/presentation/manager/splash.manager.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<SplashManager>();
    });

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
