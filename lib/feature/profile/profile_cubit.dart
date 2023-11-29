import 'package:api_part2/feature/profile/profile_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../core/database/api/api.dart';
import '../../core/database/cache/cache_helper.dart';
import '../../core/services/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());


  void logout() async {
    emit(LogoutLoadingState());
    try {
      var response = await getIt<Dio>().get(
        EndPoint.logout,
        options: Options(
          headers: {
            'token': 'FOODAPI ${CacheHelper.prefs.getString('token')} '
          },
        ),
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
      var response = await getIt<Dio>().patch(
        EndPoint.changePaswword,
        data: {
          "oldPass": "hadeer123",
          "newPass": "hadeer1234",
          "confirmPassword": "hadeer1234"
        },
        options: Options(
          headers: {
            'token': 'FOODAPI  ${CacheHelper.prefs.getString('token')} '
          },
        ),
      );
      print(response.data['message']);
      emit(ChangePasswordSuccessState());
    } catch (error) {
      print(error.toString());
      emit(ChangePasswordErrorState());
    }
  }



}
