import 'package:fl_location/src/core/network/http_client.dart';
import 'package:fl_location/src/core/network/network_info.dart';
import 'package:fl_location/src/features/home/presentation/managers/home.manager.dart';
import 'package:fl_location/src/features/location/data/datasources/location.remote_datasource.dart';
import 'package:fl_location/src/features/location/data/repositories/location.repository_impl.dart';
import 'package:fl_location/src/features/location/domain/usecases/location.repository.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppHttpClient());
    Get.lazyPut(() => NetworkInfoImpl());
    Get.lazyPut(() => LocationRemoteDatasourceImpl(Get.find<AppHttpClient>()));
    Get.lazyPut(() => LocationRepositoryImpl(
        Get.find<LocationRemoteDatasourceImpl>(), Get.find<NetworkInfoImpl>()));
    Get.lazyPut(() => SendLocationUsecase(Get.find<LocationRepositoryImpl>()));
    Get.lazyPut(() => HomeManager(Get.find<SendLocationUsecase>()));
  }
}
