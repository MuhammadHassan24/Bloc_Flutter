import 'package:bloc_counter_app/bloc/counter/counter_bloc.dart';
import 'package:bloc_counter_app/bloc/favorite/favorite_bloc.dart';
import 'package:bloc_counter_app/bloc/fetchdata/fetchdata_bloc.dart';
import 'package:bloc_counter_app/bloc/imagepicker/imagepicker_bloc.dart';
import 'package:bloc_counter_app/bloc/switch/switch_bloc.dart';
import 'package:bloc_counter_app/bloc/todo/todo_bloc.dart';
import 'package:bloc_counter_app/repository/favorite_repository.dart';
import 'package:bloc_counter_app/ui/counter_page.dart';
import 'package:bloc_counter_app/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
        BlocProvider(create: (context) => ImagePickerBloc(ImagePickerUtils())),
        BlocProvider(create: (context) => TodoBloc()),
        BlocProvider(create: (context) => FavoriteBloc(FavoriteRepository())),
        BlocProvider(create: (context) => FetchDataBloc()),
      ],
      child: BlocProvider(
        create: (context) => SwitchBloc(),
        child: MaterialApp(
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,

          home: const CounterPage(),
        ),
      ),
    );
  }
}
