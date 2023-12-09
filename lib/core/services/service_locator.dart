import 'package:api_part2/core/database/api/api_interceptor.dart';
import 'package:api_part2/core/database/api/dio_consumer.dart';
import 'package:api_part2/feature/auth/data/repositry/auth_repo.dart';
import 'package:api_part2/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../database/api/api_consumer.dart';
import '../database/api/end_points.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: EndPoint.baseUrl),
    ),
  );
  // getIt<Dio>().interceptors.add(ApiInterceptor());
  // getIt<Dio>().interceptors.add(
  //       LogInterceptor(
  //         request : true,
  //         requestHeader : true,
  //         requestBody : true,
  //         responseHeader : true,
  //         responseBody : true,
  //         error : true,
  //       ),
  //     );

  getIt.registerSingleton<ApiConsumer>(DioConsumer(dio: getIt()));
  getIt.registerSingleton<AuthRepo>(AuthRepo());
  getIt.registerSingleton<AuthCubit>(AuthCubit(getIt()));


}
