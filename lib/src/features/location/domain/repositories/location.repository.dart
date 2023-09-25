import 'package:dartz/dartz.dart';
import 'package:fl_location/src/core/errors/failures.dart';
import 'package:fl_location/src/features/location/data/dtos/send_location_body.dto.dart';
import 'package:fl_location/src/features/location/domain/entities/result.entity.dart';

abstract class LocationRepository {
  Future<Either<Failure, ResultEntity>> sendLocation(SendLocationBodyDto body);
}
