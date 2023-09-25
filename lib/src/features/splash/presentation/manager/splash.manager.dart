import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_location/src/core/router/routes.dart';
import 'package:fl_location/src/core/store/store.dart';
import 'package:get/get.dart';

class SplashManager extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await isUserLogin();
  }

  Future<void> isUserLogin() async {
    Store.user = FirebaseAuth.instance.currentUser;
    if (Store.user == null) {
      await Get.offNamed(Routes.loginPath);
    } else {
      await Get.offNamed(Routes.homePath);
    }
  }
}
