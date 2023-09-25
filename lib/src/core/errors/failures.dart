import 'package:equatable/equatable.dart';

//? Define different type of failures for each exception
class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  const CacheFailure();
}

class NetworkFailure extends Failure {
  final String message;

  //TODO Add default message
  const NetworkFailure({this.message = ''});
}

class ServerFailure extends Failure {
  final String message;
  final String request;
  const ServerFailure(this.message, this.request);

  @override
  String toString() {
    return '$request\n$message';
  }
}

class NotFoundFailure extends Failure {
  final String message;
  final String request;
  const NotFoundFailure(this.message, this.request);

  @override
  String toString() {
    return '$request\n$message';
  }
}

class BadRequestFailure extends Failure {
  final String message;
  final String request;

  const BadRequestFailure(this.message, this.request);

  @override
  String toString() {
    return '$request\n$message';
  }
}

class InternalServerFailure extends Failure {
  final String message;
  final String request;

  const InternalServerFailure(this.message, this.request);

  @override
  String toString() {
    return '$request\n$message';
  }
}

class MaintainServerFailure extends Failure {
  final String message;
  final String request;

  const MaintainServerFailure(this.message, this.request);

  @override
  String toString() {
    return '$request\n$message';
  }
}

class BadGatewayFailure extends Failure {
  final String message;
  final String request;

  const BadGatewayFailure(this.message, this.request);

  @override
  String toString() {
    return '$request\n$message';
  }
}

class AppFailure extends Failure {
  final String message;
  const AppFailure(this.message);
}


class FirebaseFailure extends Failure {
  final String message;
  final String code;
  const FirebaseFailure(this.message, this.code);
}

class AuthenticationFailure extends Failure {
  final String message;
  const AuthenticationFailure(this.message);
}
