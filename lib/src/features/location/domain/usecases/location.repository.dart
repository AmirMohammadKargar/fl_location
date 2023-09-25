import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_location/src/core/errors/failures.dart';
import 'package:fl_location/src/core/usecase/base_usecase.dart';
import 'package:fl_location/src/features/location/data/dtos/send_location_body.dto.dart';
import 'package:fl_location/src/features/location/domain/entities/result.entity.dart';
import 'package:fl_location/src/features/location/domain/repositories/location.repository.dart';

class SendLocationUsecase extends UseCase<ResultEntity, SendLocationParams> {
  final LocationRepository repository;

  SendLocationUsecase(this.repository);

  @override
  Future<Either<Failure, ResultEntity>> call(SendLocationParams params) async {
    return await repository.sendLocation(params.body);
  }
}

class SendLocationParams extends Equatable {
  final SendLocationBodyDto body;
  const SendLocationParams({required this.body});

  @override
  List<Object?> get props => [body];
}
