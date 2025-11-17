import 'package:bloc_counter_app/bloc/loginuser/loginuser_bloc.dart';
import 'package:bloc_counter_app/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginUserPage extends StatefulWidget {
  const LoginUserPage({super.key});

  @override
  State<LoginUserPage> createState() => _LoginUserPageState();
}

class _LoginUserPageState extends State<LoginUserPage> {
  late LoginUserBloc _loginUserBloc;

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loginUserBloc = LoginUserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: BlocProvider(
        create: (context) => _loginUserBloc,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 15,
            children: [
              BlocBuilder<LoginUserBloc, LoginUserState>(
                buildWhen:
                    (previous, current) => current.email != previous.email,
                builder: (context, state) {
                  return TextField(
                    focusNode: emailNode,
                    decoration: InputDecoration(
                      hintText: "Login",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (value) {
                      context.read<LoginUserBloc>().add(
                        EmailChange(email: value),
                      );
                    },
                  );
                },
              ),
              BlocBuilder<LoginUserBloc, LoginUserState>(
                buildWhen:
                    (previous, current) =>
                        current.password != previous.password,
                builder: (context, state) {
                  return TextField(
                    focusNode: passwordNode,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: (value) {
                      context.read<LoginUserBloc>().add(
                        PasswaordChange(password: value),
                      );
                    },
                  );
                },
              ),

              BlocListener<LoginUserBloc, LoginUserState>(
                listener: (context, state) {
                  if (state.loginStatus == LoginStatus.error) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text(state.message.toString())),
                      );
                    if (state.loginStatus == LoginStatus.loading) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text("Loading...")));
                    }
                  }

                  if (state.loginStatus == LoginStatus.success) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text("Login Success")));
                  }
                },
                child: BlocBuilder<LoginUserBloc, LoginUserState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<LoginUserBloc>().add(LoginApi());
                      },
                      child: Text("Login"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
