import 'package:fl_location/src/core/network/network_info.dart';
import 'package:fl_location/src/features/auth/data/datasources/auth.remote_datasource.dart';
import 'package:fl_location/src/features/auth/data/repositories/auth.repository_impl.dart';
import 'package:fl_location/src/features/auth/domain/usecases/auth.usecases.dart';
import 'package:fl_location/src/features/auth/presentation/manager/login.manager.dart';
import 'package:get/instance_manager.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkInfoImpl());
    Get.lazyPut(() => AuthRemoteDatasourceImpl());
    Get.lazyPut(() => AuthRepositoryImpl(
        Get.find<AuthRemoteDatasourceImpl>(), Get.find<NetworkInfoImpl>()));
    Get.lazyPut(() => LoginUsecase(Get.find<AuthRepositoryImpl>()));
    Get.lazyPut(() => LoginManager(Get.find<LoginUsecase>()));
  }
}
