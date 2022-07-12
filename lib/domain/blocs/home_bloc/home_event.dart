import 'package:bloc_todo/domain/entities/todo.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeLoadEvent extends HomeEvent {
  const HomeLoadEvent();
}

class HomeReadEvent extends HomeEvent {
  final Todo todo;

  const HomeReadEvent(this.todo);
}

class HomeCreateEvent extends HomeEvent {
  final Todo todo;

  const HomeCreateEvent(this.todo);
}

class HomeEditEvent extends HomeEvent {
  final Todo todo;

  const HomeEditEvent(this.todo);
}

class HomeDeleteEvent extends HomeEvent {
  final Todo todo;

  const HomeDeleteEvent(this.todo);
}