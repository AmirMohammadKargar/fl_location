import 'package:fl_location/src/core/network/http_client.dart';
import 'package:fl_location/src/features/location/data/dtos/send_location_body.dto.dart';
import 'package:fl_location/src/features/location/data/models/result.model.dart';
import 'package:fl_location/src/shared/constant/urls.dart';

abstract class LocationRemoteDatasource {
  Future<ResultModel> sendLocation(SendLocationBodyDto body);
}

class LocationRemoteDatasourceImpl implements LocationRemoteDatasource {
  final AppHttpClient httpClient;
  LocationRemoteDatasourceImpl(this.httpClient);

  @override
  Future<ResultModel> sendLocation(SendLocationBodyDto body) async {
    var res = await httpClient.post(Urls.sendLocation, data: body.toJson());
    return ResultModel.fromJson(res);
  }
}
