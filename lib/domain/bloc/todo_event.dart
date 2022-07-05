import 'package:bloc_todo/domain/entities/todo.dart';

abstract class TodoEvent {
  const TodoEvent();
}

class TodoLoadEvent extends TodoEvent {
  const TodoLoadEvent();
}

class TodoCreateEvent extends TodoEvent {
  final Todo todo;

  const TodoCreateEvent(this.todo);
}

class TodoEditEvent extends TodoEvent {
  final Todo todo;

  const TodoEditEvent(this.todo);
}

class TodoDeleteEvent extends TodoEvent {
  final Todo todo;

  const TodoDeleteEvent(this.todo);
}

abstract class SaveButtonEvent {}

class SaveButtonOnEvent extends SaveButtonEvent {}

class SaveButtonOffEvent extends SaveButtonEvent {}
