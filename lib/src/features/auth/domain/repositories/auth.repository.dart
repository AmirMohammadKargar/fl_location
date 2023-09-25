import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_location/src/core/errors/failures.dart';
import 'package:fl_location/src/features/auth/data/dtos/login_body.dto.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> login(LoginBodyDto body);
}
