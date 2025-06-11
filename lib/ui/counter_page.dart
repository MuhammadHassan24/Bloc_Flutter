import 'package:bloc_counter_app/bloc/counter/counter_bloc.dart';
import 'package:bloc_counter_app/bloc/counter/counter_event.dart';
import 'package:bloc_counter_app/bloc/counter/counter_state.dart';
import 'package:bloc_counter_app/ui/favorite_page.dart';
import 'package:bloc_counter_app/ui/image_picker_page.dart';
import 'package:bloc_counter_app/ui/switch_page.dart';
import 'package:bloc_counter_app/ui/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter Example")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.counter.toString(),
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w400),
                  );
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(IncrementCounter());
                    },
                    child: Icon(Icons.add),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(DecrementCounter());
                    },
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SwitchPage()),
                  );
                },
                child: Text("Switch App"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImagePickerPage()),
                  );
                },
                child: Text("ImagePicker App"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TodoPage()),
                  );
                },
                child: Text("Todo App"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
                  );
                },
                child: Text("Favorite App"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
