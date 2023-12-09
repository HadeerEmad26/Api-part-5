import 'package:api_part2/core/error/exceptions.dart';
import 'package:api_part2/core/error/failuer.dart';
import 'package:api_part2/feature/auth/data/model/login_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/api/api_consumer.dart';
import '../../../../core/database/api/end_points.dart';
import '../../../../core/services/service_locator.dart';

class AuthRepo {
  //login
  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await getIt<ApiConsumer>().post(
        EndPoint.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      return Right(LoginModel.fromJson(response.data));
    } on ServerException catch(error){
      print(error.errorModel.errorMessage);
      return Left(ServerFailure(errorModel: error.errorModel));
    }
  }

  //logout
}
