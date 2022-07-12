// ignore_for_file: use_build_context_synchronously

export 'home_event.dart';
export 'home_state.dart';

import 'package:bloc_todo/domain/blocs/detail_bloc/detail_bloc.dart';
import 'package:bloc_todo/domain/entities/todo.dart';
import 'package:bloc_todo/domain/services/todo_api_provider.dart';
import 'package:bloc_todo/ui/app.dart';
import 'package:bloc_todo/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeLoadEvent>(_todoLoadEvent);
    on<HomeCreateEvent>(_todoCreteEvent);
    on<HomeEditEvent>(_todoEditEvent);
    on<HomeDeleteEvent>(_todoDeleteEvent);
  }

  void _todoLoadEvent(HomeLoadEvent event, Emitter<HomeState> emit) async {
    final todos = await todoApiProvider.getTodos();

    emit(HomeState(todosList: todos));
  }

  void _todoCreteEvent(HomeCreateEvent event, Emitter<HomeState> emit) async {
    final todo = await todoApiProvider.createTodo(event.todo.toJson());

    emit(HomeState(
      todosList: [todo, ...state.todosList],
    ));
  }

  void _todoEditEvent(HomeEditEvent event, Emitter<HomeState> emit) {
    final index = state.todosList.indexWhere(
      (element) => element.id! == event.todo.id!,
    );

    todoApiProvider.updateTodo(event.todo.id, event.todo.toJson());

    emit(
      HomeState(
        todosList: state.todosList
          ..insert(index, event.todo)
          ..removeAt(index + 1),
      ),
    );
  }

  void _todoDeleteEvent(HomeDeleteEvent event, Emitter<HomeState> emit) {
    final index = state.todosList.indexWhere(
      (element) => element.id == event.todo.id,
    );

    todoApiProvider.deleteTodo(event.todo.id!);

    emit(
      HomeState(
        todosList: state.todosList..removeAt(index),
      ),
    );
  }


  // ! controll methods
  void openForCreate(BuildContext context) async {
    await Navigator.pushNamed(
      context,
      DetailPage.id,
      arguments: const RouteArgs(
        detailState: DState.creat,
        todo: null,
      ),
    );

    context.read<HomeBloc>().add(const HomeLoadEvent());
  }

  void openForRead(BuildContext context, Todo todo) async {
    await Navigator.pushNamed(
      context,
      DetailPage.id,
      arguments: RouteArgs(
        detailState: DState.read,
        todo: todo,
      ),
    );

    context.read<HomeBloc>().add(const HomeLoadEvent());
  }

  void openForEdit(BuildContext context, Todo todo) async {
    await Navigator.pushNamed(
      context,
      DetailPage.id,
      arguments: RouteArgs(
        detailState: DState.edit,
        todo: todo,
      ),
    );

    context.read<HomeBloc>().add(const HomeLoadEvent());
  }
}
