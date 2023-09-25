import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_location/src/core/errors/failures.dart';
import 'package:fl_location/src/core/usecase/base_usecase.dart';
import 'package:fl_location/src/features/auth/data/dtos/login_body.dto.dart';
import 'package:fl_location/src/features/auth/domain/repositories/auth.repository.dart';

class LoginUsecase extends UseCase<UserCredential, LoginParams> {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(LoginParams params) async {
    return await repository.login(params.body);
  }
}

class LoginParams extends Equatable {
  final LoginBodyDto body;
  const LoginParams({required this.body});

  @override
  List<Object?> get props => [body];
}

//--------------------------------------------------

class LogoutUsecase extends UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}
