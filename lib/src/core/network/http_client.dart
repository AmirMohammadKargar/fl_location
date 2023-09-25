import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_location/src/core/errors/exceptions.dart';
import 'package:fl_location/src/core/store/store.dart';
import 'package:fl_location/src/shared/constant/urls.dart';
import 'package:flutter/foundation.dart';

typedef RequestFunc = Future<dynamic> Function();

// Singleton class for making HTTP requests
class AppHttpClient {
  var dio = createDio(); // Create a Dio instance

  static var innerClient = createDio(); // Create another Dio instance

  CancelToken cancelToken = CancelToken(); // Token for cancelling requests

  void cancelRequest() {
    cancelToken.cancel(); // Cancel the current request
    cancelToken = CancelToken(); // Create a new token for future requests
  }

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        receiveTimeout: const Duration(milliseconds: 15000),
        connectTimeout: const Duration(milliseconds: 15000),
        sendTimeout: const Duration(milliseconds: 15000),
      ),
    );

    dio.interceptors.addAll({
      AppInterceptors(dio), // Add custom interceptors to the Dio instance
    });

    return dio;
  }

  Future<void> setHeader(bool isUploading) async {
    // Set request timeout durations based on the debug mode
    innerClient.options.sendTimeout = isUploading
        ? const Duration(minutes: 10)
        : kDebugMode
            ? const Duration(milliseconds: 60000)
            : const Duration(milliseconds: 20000);
    innerClient.options.connectTimeout = isUploading
        ? const Duration(minutes: 10)
        : kDebugMode
            ? const Duration(milliseconds: 60000)
            : const Duration(milliseconds: 20000);
    innerClient.options.receiveTimeout = isUploading
        ? const Duration(minutes: 10)
        : kDebugMode
            ? const Duration(milliseconds: 60000)
            : const Duration(milliseconds: 20000);
    innerClient.options.headers['Authorization'] =
        Store.user != null ? '${Store.user!.refreshToken}' : '';
  }

  // Generic function for handling HTTP requests with error handling
  Future<dynamic> tryCatch(
    RequestFunc func,
    String path, {
    bool cachedResponse = false,
    bool isPaginated = false,
    bool isUploading = false,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      // Set all headers
      await setHeader(isUploading);

      // Make the HTTP request using the provided function
      var response = await func();

      var json = response.data; // Extract the response data as JSON

      return json;
    } on DioException catch (e) {
      switch (e.response!.statusCode) {
        // Handle different HTTP status codes
        case 400:
          throw BadRequestException(
              request: path,
              message: e.response != null && e.response!.data != null
                  ? e.response!.data is Map
                      ? e.response!.data['message']
                      : e.response!.data
                  : e.message);
        case 401:
          throw AuthenticationException(
              message: e.response != null && e.response!.data != null
                  ? e.response!.data is Map
                      ? e.response!.data['message']
                      : e.response!.data
                  : e.message);
        case 403:
          throw AuthenticationException(
              message: e.response != null && e.response!.data != null
                  ? e.response!.data is Map
                      ? e.response!.data['message']
                      : e.response!.data
                  : e.message);
        case 404:
          throw NotFoundException(
              request: path,
              message: e.response != null && e.response!.data != null
                  ? e.response!.data is Map
                      ? e.response!.data['message']
                      : e.response!.data
                  : e.message);
        case 500:
          throw InternalServerException(
              request: path,
              message: e.response != null && e.response!.data != null
                  ? e.response!.data is Map
                      ? e.response!.data['message']
                      : e.response!.data
                  : e.message);
        case 502:
          throw BadGatewayException(request: path, message: 'خطای سرور');
        case 504:
          throw BadGatewayException(request: path, message: 'خطای سرور');
        case 503:
          throw MaintainServerException(
              request: path,
              message: e.response != null && e.response!.data != null
                  ? e.response!.data is Map
                      ? e.response!.data['message']
                      : e.response!.data
                  : e.message);
        default:
          throw ServerException(
              request: path,
              message: e.response != null && e.response!.data != null
                  ? e.response!.data is Map
                      ? e.response!.data['message']
                      : e.response!.data
                  : e.message);
      }
    } catch (err) {
      throw AppException();
    }
  }

  // Generic function for making GET requests
  Future<dynamic> get<T, M>(
    String path, {
    bool cachedResponse = false,
    bool isPaginated = false,
    Map<String, dynamic>? queryParams,
  }) async {
    return await tryCatch(
        () => innerClient.get(
              Urls.baseUrl + path,
              cancelToken: cancelToken,
              queryParameters: queryParams,
            ),
        path,
        cachedResponse: cachedResponse,
        isPaginated: isPaginated);
  }

  // Generic function for making POST requests
  Future<dynamic> post(String path,
      {bool cachedResponse = false,
      bool isPaginated = false,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? data,
      FormData? formData,
      File? file}) async {
    FormData? requestBody;
    if (file != null) {
      var fileName = file.path.split('/').last;
      requestBody = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });
    }
    return await tryCatch(
        () => innerClient.post(
              Urls.baseUrl + path,
              cancelToken: cancelToken,
              queryParameters: queryParams,
              data: formData ?? requestBody ?? data,
            ),
        path,
        isUploading: formData != null,
        cachedResponse: cachedResponse,
        isPaginated: isPaginated);
  }

  // Generic function for making PUT requests
  Future<dynamic> put(
    String path, {
    bool cachedResponse = false,
    bool isPaginated = false,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
  }) async {
    return await tryCatch(
        () => innerClient.put(
              Urls.baseUrl + path,
              cancelToken: cancelToken,
              queryParameters: queryParams,
              data: data,
            ),
        path,
        cachedResponse: cachedResponse,
        isPaginated: isPaginated);
  }

  // Generic function for making PATCH requests
  Future<dynamic> patch(
    String path, {
    bool cachedResponse = false,
    bool isPaginated = false,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    return await tryCatch(
        () => innerClient.patch(
              Urls.baseUrl + path,
              cancelToken: cancelToken,
              queryParameters: queryParams,
              data: formData ?? data,
            ),
        path,
        cachedResponse: cachedResponse,
        isPaginated: isPaginated);
  }

  // Generic function for making DELETE requests
  Future<dynamic> delete(
    String path, {
    bool cachedResponse = false,
    bool isPaginated = false,
    Map<String, dynamic>? queryParams,
  }) async {
    return await tryCatch(
        () => innerClient.delete(
              Urls.baseUrl + path,
              cancelToken: cancelToken,
              queryParameters: queryParams,
            ),
        path,
        cachedResponse: cachedResponse,
        isPaginated: isPaginated);
  }
}

// Custom interceptor for logging API requests and responses
class AppInterceptors extends InterceptorsWrapper {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      log('''
        =========== API Request - Start ===========
        URI ${options.uri}
        METHOD ${options.method}
        HEADERS ${options.headers} 
        BODY ${options.data}
        =========== API Request - End ===========
        ''');
    }
    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      log('''
        =========== API Response - Start ===========
        URI ${response.requestOptions.uri}
        STATUS CODE ${response.statusCode} 
        METHOD ${response.requestOptions.method}
        BODY ${response.data}
        =========== API Response - End ===========
        ''');
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      if (kDebugMode) {
        log('''
        =========== API Error - Start ===========
        URI ${err.requestOptions.uri}
        STATUS CODE ${err.response?.statusCode} 
        ERROR ${err.response}
        =========== API Error - End ===========
        ''');
      }
    } else {
      if (kDebugMode) {
        log('''
        =========== API Error - Start ===========
        URI ${err.requestOptions.uri}
        STATUS CODE 
        ERROR 
        =========== API Error - End ===========
        ''');
      }
    }

    return handler.next(err);
  }
}
