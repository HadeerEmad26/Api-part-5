import 'package:api_part2/core/database/api/api_consumer.dart';
import 'package:api_part2/core/database/api/end_points.dart';
import 'package:api_part2/core/database/cache/cache_helper.dart';
import 'package:api_part2/core/services/service_locator.dart';
import 'package:api_part2/core/utils/commens.dart';
import 'package:api_part2/feature/auth/data/model/login_model.dart';
import 'package:api_part2/feature/auth/data/repositry/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final Dio dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl));
  final AuthRepo authRepo;

  void login() async {
     var data=  await authRepo.login(
      email:"hadeere378@gmail.com",
      password: "hadeer1234",
    );
     data.fold((l) => printError(l.errorModel.errorMessage),
             (r) => printResponse(r.message));








    // try {
    //   var response = await getIt<ApiConsumer>().post(
    //     EndPoint.login,
    //     data: {
    //       "email": "hadeere378@gmail.com",
    //       "password": "hadeer1234",
    //     },
    //   );
    //   // print(response.statusCode);
    //   // print(response.data);
    //   var loginModel = LoginModel.fromJson(response.data);
    //   await CacheHelper.prefs.setString('token', loginModel.token);
    //
    //   print(loginModel.message);
    //   Map<String, dynamic> decodedToken = JwtDecoder.decode(loginModel.token);
    //   print(decodedToken['id']);
    //   await CacheHelper.prefs.setString('id', decodedToken['id']);
    //
    //   emit(LoginSuccessState());
    // } catch (error) {
    //   print(error.toString());
    //   emit(LoginErrorState());
    // }
  }

  void logout() async {
    emit(LogoutLoadingState());
    try {
      var response = await getIt<ApiConsumer>().get(
        EndPoint.logout,
        // options: Options(
        //   headers: {
        //     'token': 'FOODAPI ${CacheHelper.prefs.getString('token')} '
        //   },
        // ),
      );
      print(response.data['message']);
      emit(LogoutSuccessState());
    } catch (error) {
      print(error.toString());
      emit(LogoutErrorState());
    }
  }

  void changePassword() async {
    emit(ChangePasswordLoadingState());
    try {
      var response = await getIt<ApiConsumer>().patch(
        EndPoint.changePaswword,
        data: {
          "oldPass": "hadeer123",
          "newPass": "hadeer1234",
          "confirmPassword": "hadeer1234"
        },
        // options: Options(
        //   headers: {
        //     'token': 'FOODAPI  ${CacheHelper.prefs.getString('token')} '
        //   },
        // ),
      );
      print(response.data['message']);
      emit(ChangePasswordSuccessState());
    } catch (error) {
      print(error.toString());
      emit(ChangePasswordErrorState());
    }
  }

  void deleteChef() async {
    emit(DeleteLoadingState());
    try {
      var response = await getIt<ApiConsumer>().delete(
        EndPoint.deleteChef,
        queryParameters: {
          'id': CacheHelper.prefs.getString('id'),
        },
        // options: Options(
        //   headers: {
        //     'token': 'FOODAPI  ${CacheHelper.prefs.getString('token')} '
        //   },
        // ),
      );
      print(response.data);
      emit(DeleteSuccessState());
    } catch (error) {
      print(error.toString());
      emit(DeleteErrorState());
    }
  }
}
