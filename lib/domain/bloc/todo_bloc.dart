import 'package:bloc_todo/domain/bloc/todo_event.dart';
import 'package:bloc_todo/domain/bloc/todo_state.dart';
import 'package:bloc_todo/domain/services/todo_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<TodoLoadEvent>(_todoLoadEvent);
    on<TodoCreateEvent>(_todoCreteEvent);
    on<TodoEditEvent>(_todoEditEvent);
    on<TodoDeleteEvent>(_todoDeleteEvent);
  }

  void _todoLoadEvent(TodoLoadEvent event, Emitter<TodoState> emit) async {
    final todos = await todoApiProvider.getTodos();

    emit(TodoState(todosList: todos));
  }

  void _todoCreteEvent(TodoCreateEvent event, Emitter<TodoState> emit) async {
    final todo = await todoApiProvider.createTodo(event.todo);

    emit(TodoState(
      todosList: [todo, ...state.todosList],
    ));
  }

  void _todoEditEvent(TodoEditEvent event, Emitter<TodoState> emit) {
    final index = state.todosList.indexWhere(
      (element) => element.id! == event.todo.id!,
    );

    todoApiProvider.updateTodo(event.todo);

    emit(
      TodoState(
        todosList: state.todosList
          ..insert(index, event.todo)
          ..removeAt(index + 1),
      ),
    );
  }

  void _todoDeleteEvent(TodoDeleteEvent event, Emitter<TodoState> emit) {
    final index = state.todosList.indexWhere(
      (element) => element.id == event.todo.id,
    );

    todoApiProvider.deleteTodo(event.todo.id!);

    emit(
      TodoState(
        todosList: state.todosList..removeAt(index),
      ),
    );
  }
}

class SaveButtonBloc extends Bloc<SaveButtonEvent, SaveButtonState> {
  SaveButtonBloc() : super(SaveButtonState()) {
    on<SaveButtonOnEvent>(_saveButtonOn);
    on<SaveButtonOffEvent>(_saveButtonOff);
  }

  void _saveButtonOn(event, emit) {
    emit(SaveButtonState(isEmpty: false));
  }

  void _saveButtonOff(event, emit) {
    emit(SaveButtonState(isEmpty: true));
  }
}
