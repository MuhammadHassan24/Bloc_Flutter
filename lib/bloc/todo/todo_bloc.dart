import 'package:bloc/bloc.dart';
import 'package:bloc_counter_app/bloc/todo/todo_event.dart';
import 'package:bloc_counter_app/bloc/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<String> todoList = [];
  TodoBloc() : super(TodoState()) {
    on<AddTodoEvent>(_addTodo);
    on<RemoveTodoEvent>(_removeTodo);
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    todoList.add(event.task);
    emit(state.copyWith(todosList: List.from(todoList)));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoState> emit) {
    todoList.remove(event.task);
    emit(state.copyWith(todosList: List.from(todoList)));
  }
}
