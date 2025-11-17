part of 'loginuser_bloc.dart';

sealed class LoginUserEvent extends Equatable {
  const LoginUserEvent();

  @override
  List<Object> get props => [];
}

class EmailChange extends LoginUserEvent {
  final String email;
  const EmailChange({required this.email});

  @override
  // TODO: implement props
  List<Object> get props => [email];
}

class PasswaordChange extends LoginUserEvent {
  final String password;
  const PasswaordChange({required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [password];
}

class LoginApi extends LoginUserEvent {}
