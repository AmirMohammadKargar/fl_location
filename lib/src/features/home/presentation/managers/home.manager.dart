import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:fl_location/src/core/errors/error_handler.dart';
import 'package:fl_location/src/core/router/routes.dart';
import 'package:fl_location/src/core/store/store.dart';
import 'package:fl_location/src/core/usecase/base_usecase.dart';
import 'package:fl_location/src/features/auth/domain/usecases/auth.usecases.dart';
import 'package:fl_location/src/features/location/data/dtos/send_location_body.dto.dart';
import 'package:fl_location/src/features/location/domain/usecases/location.repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeManager extends GetxController {
  final SendLocationUsecase _sendLocationUsecase;
  final LogoutUsecase _logoutUsecase;
  HomeManager(this._sendLocationUsecase, this._logoutUsecase);

  Timer? backgrounTimer;
  bool _serviceEnabled = false;
  LocationPermission _permission = LocationPermission.denied;
  Position? _userPosition;
  StreamSubscription<Position>? _locationSubscription;

  Position? get position => _userPosition;

  @override
  void onInit() async {
    super.onInit();
    await _getLocationPermission();
    if (_havePermission) {
      _startBackgroundTasks();
    }
  }

  @override
  void dispose() {
    backgrounTimer?.cancel();
    _locationSubscription?.cancel();
    super.dispose();
  }

  void _startBackgroundTimer() {
    backgrounTimer?.cancel();
    backgrounTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _sendLocationInBackground();
    });
  }

  bool get _havePermission {
    return _permission == LocationPermission.always ||
        _permission == LocationPermission.whileInUse;
  }

  void _sendLocationInBackground() async {
    var position = await Geolocator.getCurrentPosition();
    var body =
        SendLocationBodyDto(lat: position.latitude, lang: position.longitude);
    unawaited(
      _sendLocationUsecase.call(SendLocationParams(body: body)).then((value) {
        value.fold(
            (failure) => ErrorHandler.showErrorSnackBar(
                Get.context!, ErrorHandler.getErrorMessage(failure)),
            (r) => null);
      }),
    );
  }

  Future<void> _getLocationPermission() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied ||
          _permission == LocationPermission.deniedForever) {
        showPremissionDialog();
      } else {
        _startBackgroundTasks();
      }
    } else if (_permission == LocationPermission.deniedForever) {
      showPremissionDialog();
    }
  }

  void _startBackgroundTasks() {
    _startBackgroundTimer();
    _getUserLocation();
  }

  void _getUserLocation() {
    _locationSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((position) {
      _userPosition = position;
      update();
    });
  }

  void showPremissionDialog() {
    Get.defaultDialog(
        barrierDismissible: false,
        title: 'Location Permission',
        middleText: 'App Need Location Permission',
        textConfirm: 'Grant Permission',
        onConfirm: () async {
          Navigator.of(Get.overlayContext!).pop();
          await AppSettings.openAppSettings(type: AppSettingsType.location);
          await _getLocationPermission();
        });
  }

  Future<void> logout() async {
    var res = await _logoutUsecase.call(NoParams());
    res.fold(
        (failure) => ErrorHandler.showErrorSnackBar(
            Get.context!, ErrorHandler.getErrorMessage(failure)), (r) {
      Store.logout();
      Get.offAndToNamed(Routes.loginPath);
    });
  }
}
