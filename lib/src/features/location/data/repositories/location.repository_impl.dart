// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:fl_location/src/core/errors/exception_handler.dart';
import 'package:fl_location/src/core/errors/failures.dart';
import 'package:fl_location/src/core/network/network_info.dart';
import 'package:fl_location/src/features/location/data/datasources/location.remote_datasource.dart';
import 'package:fl_location/src/features/location/data/dtos/send_location_body.dto.dart';
import 'package:fl_location/src/features/location/domain/entities/result.entity.dart';
import 'package:fl_location/src/features/location/domain/repositories/location.repository.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;

  LocationRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ResultEntity>> sendLocation(
      SendLocationBodyDto body) async {
    return exceptionHandler<ResultEntity>(() async {
      return await remoteDataSource.sendLocation(body);
    }, networkInfo);
  }
}
