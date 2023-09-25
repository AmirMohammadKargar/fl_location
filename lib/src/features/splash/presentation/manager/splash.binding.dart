import 'package:fl_location/src/features/splash/presentation/manager/splash.manager.dart';
import 'package:get/instance_manager.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashManager());
  }
}
