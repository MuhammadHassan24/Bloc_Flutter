import 'package:bloc_counter_app/bloc/todo/todo_bloc.dart';
import 'package:bloc_counter_app/bloc/todo/todo_event.dart';
import 'package:bloc_counter_app/bloc/todo/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo Page"), centerTitle: true),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.todosList.isEmpty) {
            return Center(child: Text("Todo is empty"));
          } else if (state.todosList.isNotEmpty) {
            return ListView.builder(
              itemCount: state.todosList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.todosList[index],
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<TodoBloc>().add(
                        RemoveTodoEvent(task: state.todosList[index]),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              final con = TextEditingController();
              return AlertDialog(
                title: Text("Add Task"),
                content: TextField(controller: con),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (con.text == " ") {
                        return;
                      } else {
                        context.read<TodoBloc>().add(
                          AddTodoEvent(task: con.text.toString()),
                        );
                        con.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Text("Add"),
      ),
    );
  }
}
