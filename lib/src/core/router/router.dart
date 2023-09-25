import 'package:fl_location/src/core/router/routes.dart';
import 'package:fl_location/src/features/auth/presentation/manager/login.binding.dart';
import 'package:fl_location/src/features/auth/presentation/pages/login.screen.dart';
import 'package:fl_location/src/features/home/presentation/managers/home.binding.dart';
import 'package:fl_location/src/features/home/presentation/pages/home.screen.dart';
import 'package:fl_location/src/features/splash/presentation/manager/splash.binding.dart';
import 'package:fl_location/src/features/splash/presentation/page/splash.screen.dart';
import 'package:get/route_manager.dart';

class AppRouter {
  static final getPages = [
    GetPage(
      name: Routes.splashPath,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.loginPath,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.homePath,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    )
  ];
}
