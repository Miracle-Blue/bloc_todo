export 'detail_event.dart';
export 'detail_state.dart';

import 'package:bloc_todo/domain/blocs/home_bloc/home_bloc.dart';
import 'package:bloc_todo/domain/entities/todo.dart';
import 'package:bloc_todo/domain/services/todo_api_provider.dart';
import 'package:bloc_todo/ui/app.dart';
import 'package:bloc_todo/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'detail_event.dart';
import 'detail_state.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  bool readOnly = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  set setTodo(Todo? todo) {
    state.todo ??= todo;

    if (state.deatilState == DState.read) {
      readOnly = true;
    } else {
      readOnly = false;
    }
  }

  DetailBloc() : super(DetailState());

  void editTodo(BuildContext context) {
    final newTodo = Todo(
      id: state.todo!.id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      createdTime: DateFormat('dd-MM-yyyy  |  hh:mm:ss').format(DateTime.now()),
    );

    context.read<HomeBloc>().add(HomeEditEvent(newTodo));

    Navigator.pop(context);
  }

  void createTodo(BuildContext context) {
    final newTodo = Todo(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      createdTime: DateFormat('dd-MM-yyyy  |  hh:mm:ss').format(DateTime.now()),
    );

    context.read<HomeBloc>().add(HomeCreateEvent(newTodo));

    Navigator.pop(context);
  }

  void pressedEdit(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      DetailPage.id,
      arguments: RouteArgs(
        detailState: DState.edit,
        todo: state.todo,
      ),
    );
  }

  void pressedSave(BuildContext context) async {
    switch (state.deatilState) {
      case DState.creat:
        createTodo(context);
        break;
      case DState.edit:
        editTodo(context);
        break;
      default:
        break;
    }
  }
}
