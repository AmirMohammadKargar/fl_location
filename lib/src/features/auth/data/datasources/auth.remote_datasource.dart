import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_location/src/features/auth/data/dtos/login_body.dto.dart';

abstract class AuthRemoteDatasource {
  Future<UserCredential> login(LoginBodyDto body);
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl();

  @override
  Future<UserCredential> login(LoginBodyDto body) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: body.email,
      password: body.password,
    );
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
