import 'package:firebase_core/firebase_core.dart';
import 'package:fl_location/firebase_options.dart';
import 'package:fl_location/src/core/router/router.dart';
import 'package:fl_location/src/core/router/routes.dart';
import 'package:fl_location/src/core/theme/theme.dart';
import 'package:fl_location/src/features/splash/presentation/manager/splash.binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.splashPath,
      initialBinding: SplashBinding(),
      getPages: AppRouter.getPages,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.ligthTheme,
    );
  }
}
