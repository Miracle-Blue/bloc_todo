import 'package:bloc_todo/domain/entities/todo.dart';

class TodoState {
  final List<Todo> todosList;

  TodoState({
    this.todosList = const <Todo>[],
  });
}

class SaveButtonState {
  final bool isEmpty;

  SaveButtonState({
    this.isEmpty = true,
  });
}
