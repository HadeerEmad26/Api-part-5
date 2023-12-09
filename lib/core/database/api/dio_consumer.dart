import 'package:api_part2/core/database/api/api_consumer.dart';
import 'package:api_part2/core/database/api/api_interceptor.dart';
import 'package:api_part2/core/database/api/end_points.dart';
import 'package:dio/dio.dart';

import '../../error/error_model.dart';
import '../../error/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options //.. to add something else
      ..baseUrl = EndPoint.baseUrl
      ..connectTimeout = Duration(seconds: 20);

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true
    ));
    dio.interceptors.add(ApiInterceptor());
  }

  @override
  Future delete(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.delete(path,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      return response;
    }on DioException catch(dioError){
      _handleDioError(dioError);
    }
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(path,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      return response;
    }on DioException catch(dioError){
      _handleDioError(dioError);
    }
  }

  @override
  Future patch(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.patch(path,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      return response;
    }on DioException catch(dioError) {
      _handleDioError(dioError);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.post(path,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      return response;
    }on DioException catch(dioError){
      _handleDioError(dioError);
    }
  }

  _handleDioError(DioException dioException){
    switch (dioException.type) {
      case DioExceptionType.badCertificate:
        throw BadCertificateException(ErrorModel.fromJson(dioException.response!.data));
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutException(ErrorModel.fromJson(dioException.response!.data));
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
        throw ServerException(ErrorModel.fromJson(dioException.response!.data));

      case DioExceptionType.badResponse:
        switch (dioException.response?.statusCode) {
          case 400: //bad request
            throw BadRequestException(ErrorModel.fromJson(dioException.response!.data));

          case 401: //unauthorized
            throw UnauthorizedException(ErrorModel.fromJson(dioException.response!.data));

          case 403: //forbidden
            throw ForbiddenException(ErrorModel.fromJson(dioException.response!.data));

          case 404: //notFound
            throw NotFoundException(ErrorModel.fromJson(dioException.response!.data));

          case 409: //conflict
            throw ConflictException(ErrorModel.fromJson(dioException.response!.data));
          case 504:
            throw BadRequestException(ErrorModel.fromJson(dioException.response!.data));

        // print(e.response);
        }
      case DioExceptionType.cancel:
        throw ServerException(ErrorModel(statusCode: 500, errorMessage: dioException.toString()));

      case DioExceptionType.unknown:
        throw ServerException(ErrorModel(statusCode: 500, errorMessage: dioException.toString()));

    // throw ServerException('badResponse');
    }
  }
  }


