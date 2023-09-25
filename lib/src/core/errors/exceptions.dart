//* Define different types of exception may happened in app

class NetworkException implements Exception {
  final String message;
  NetworkException({
    this.message = 'No connection',
  });
}

class ServerException implements Exception {
  final String message;
  final String request;
  ServerException({
    this.message = 'Server Error',
    required this.request,
  });
}

class NotFoundException implements Exception {
  final String message;
  final String request;
  NotFoundException({
    this.message = 'Page not found',
    required this.request,
  });
}

class InternalServerException implements Exception {
  final String message;
  final String request;
  InternalServerException({
    this.message = 'Internal Server Error',
    required this.request,
  });
}

class BadGatewayException implements Exception {
  final String message;
  final String request;
  BadGatewayException({
    this.message = 'Bad Gateway',
    required this.request,
  });
}

class MaintainServerException implements Exception {
  final String message;
  final String request;
  MaintainServerException({
    this.message = 'Server is under maintain',
    required this.request,
  });
}

class BadRequestException implements Exception {
  final String message;
  final String request;
  BadRequestException({
    this.message = 'Bad Request',
    required this.request,
  });
}

class AppException implements Exception {
  final String message;
  AppException({
    this.message = 'App Error',
  });
}

class CacheException implements Exception {
  final String message;
  CacheException({
    this.message = 'Cache Error',
  });
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException({
    this.message = 'Authentication Error',
  });
}

class CancelException implements Exception {
  final String message;
  CancelException({
    this.message = 'Cancel Request Error',
  });
}
