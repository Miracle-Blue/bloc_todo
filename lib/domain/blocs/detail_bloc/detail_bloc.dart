export 'detail_event.dart';
export 'detail_state.dart';

import 'package:bloc_todo/domain/blocs/home_bloc/home_bloc.dart';
import 'package:bloc_todo/domain/entities/todo.dart';
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

    if (state.detailState == DState.read) {
      readOnly = true;
    } else {
      readOnly = false;
    }
  }

  DetailBloc() : super(DetailState());

  // ! control methods
  void editTodo(BuildContext context) {
    final newTodo = Todo(
      id: state.todo!.id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      createdTime: DateFormat('dd-MM-yyyy  |  hh:mm:ss').format(DateTime.now()),
    );

    context.read<HomeBloc>().add(HomeEditEvent(newTodo));

    titleController.clear();
    descriptionController.clear();

    Navigator.pop(context);
  }

  void createTodo(BuildContext context) {
    final newTodo = Todo(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      createdTime: DateFormat('dd-MM-yyyy  |  hh:mm:ss').format(DateTime.now()),
    );

    context.read<HomeBloc>().add(HomeCreateEvent(newTodo));

    titleController.clear();
    descriptionController.clear();

    Navigator.pop(context);
  }

  void pressedEdit(BuildContext context, Todo todo) {

    titleController.clear();
    descriptionController.clear();

    Navigator.pushReplacementNamed(
      context,
      DetailPage.id,
      arguments: RouteArgs(
        detailState: DState.edit,
        todo: todo,
      ),
    );
  }

  void pressedSave(BuildContext context) async {
    switch (state.detailState) {
      case DState.create:
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
