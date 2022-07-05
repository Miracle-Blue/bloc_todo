import 'package:bloc_todo/domain/bloc/todo_bloc.dart';
import 'package:bloc_todo/domain/bloc/todo_event.dart';
import 'package:bloc_todo/domain/bloc/todo_state.dart';
import 'package:bloc_todo/domain/entities/todo.dart';
import 'package:bloc_todo/domain/services/todo_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_page.dart';
import 'edit_page.dart';

class HomePage extends StatelessWidget {
  static const id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     context.read<TodoBloc>().add(const TodoLoadEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todosList.length,
            itemBuilder: (context, index) {
              return TodoList(todo: state.todosList[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreatePage.id);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final Todo todo;

  const TodoList({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: ListTile(
        title: Text(
          todo.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          todo.description,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, EditPage.id, arguments: todo);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<TodoBloc>().add(TodoDeleteEvent(todo));
              },
            ),
          ],
        ),
      ),
    );
  }
}
