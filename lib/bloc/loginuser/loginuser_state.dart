part of 'loginuser_bloc.dart';

class LoginUserState extends Equatable {
  const LoginUserState({
    this.email = '',
    this.password = "",
    this.message = "",
    this.loginStatus = LoginStatus.initial,
  });

  final String email;
  final String password;
  final String message;
  final LoginStatus loginStatus;

  LoginUserState copyWith({
    String? email,
    String? password,
    String? message,
    LoginStatus? loginStatus,
  }) {
    return LoginUserState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  List<Object> get props => [email, password, message, loginStatus];
}

final class LoginUserInitial extends LoginUserState {}
