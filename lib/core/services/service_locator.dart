import 'package:api_part2/core/database/api/app/api_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../database/api/api.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: EndPoint.baseUrl),
    ),
  );
  getIt<Dio>().interceptors.add(
        LogInterceptor(
          request : true,
          requestHeader : true,
          requestBody : true,
          responseHeader : true,
          responseBody : true,
          error : true,
        ),
      );
  getIt<Dio>().interceptors.add(ApiInterceptor());
}
