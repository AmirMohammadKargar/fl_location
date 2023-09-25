// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_location/src/core/errors/exception_handler.dart';
import 'package:fl_location/src/core/errors/failures.dart';
import 'package:fl_location/src/core/network/network_info.dart';
import 'package:fl_location/src/features/auth/data/datasources/auth.remote_datasource.dart';
import 'package:fl_location/src/features/auth/data/dtos/login_body.dto.dart';
import 'package:fl_location/src/features/auth/domain/repositories/auth.repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, UserCredential>> login(LoginBodyDto body) {
    return exceptionHandler<UserCredential>(() async {
      return await remoteDataSource.login(body);
    }, networkInfo, convertToEntity: false);
  }

  @override
  Future<Either<Failure, void>> logout() {
    return exceptionHandler<void>(() async {
      return await remoteDataSource.logout();
    }, networkInfo, convertToEntity: false);
  }
}
