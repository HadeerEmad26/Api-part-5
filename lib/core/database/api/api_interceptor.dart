import 'package:dio/dio.dart';

import '../cache/cache_helper.dart';

class ApiInterceptor extends Interceptor{

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    print("--------Request------------");
    options.headers['token']= 'FOODAPI  ${CacheHelper.prefs.getString('token')}';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    print("--------Response------------");
    super.onResponse(response, handler);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    super.onError(err, handler);
  }

}


