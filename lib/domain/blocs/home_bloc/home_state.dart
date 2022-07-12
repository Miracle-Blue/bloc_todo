import 'package:bloc_todo/domain/entities/todo.dart';

class HomeState {
  final List<Todo> todosList;

  const HomeState({
    this.todosList = const <Todo>[],
  });
}

