abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {
  final String message;

  LoginLoadingState({
    required this.message,
  });
}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState({
   required this.message,
  });
}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutErrorState extends AuthState {}

class ChangePasswordLoadingState extends AuthState {}

class ChangePasswordSuccessState extends AuthState {}

class ChangePasswordErrorState extends AuthState {}

class DeleteLoadingState extends AuthState {}

class DeleteSuccessState extends AuthState {}

class DeleteErrorState extends AuthState {}