import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_counter_app/utils/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'loginuser_event.dart';
part 'loginuser_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  LoginUserBloc() : super(LoginUserState()) {
    on<PasswaordChange>(_passwordChange);
    on<EmailChange>(_emailChange);
    on<LoginApi>(_loginApi);
  }

  void _emailChange(EmailChange event, Emitter<LoginUserState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChange(PasswaordChange event, Emitter<LoginUserState> emit) {
    emit(state.copyWith(email: event.password));
  }

  void _loginApi(LoginApi event, Emitter<LoginUserState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    final data = {"email": "eve.holt@reqres.in", "password": "cityslicka"};
    try {
      final response = await http.post(
        Uri.parse("https://reqres.in/api/login?api_key=reqres-free-v1"),
        body: data,
        headers: {"x-api-key": "reqres-free-v1"},
      );
      log(response.toString());
      final error = json.decode(response.body);
      log(error.toString());
      if (response.statusCode == 200) {
        state.copyWith(
          loginStatus: LoginStatus.success,
          message: "Login Successful",
        );
      } else {
        state.copyWith(
          loginStatus: LoginStatus.error,
          message: error.toString(),
        );
      }
    } catch (e) {
      state.copyWith(loginStatus: LoginStatus.error, message: e.toString());
    }
  }
}
