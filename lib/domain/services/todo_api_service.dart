import 'dart:convert';

import 'package:bloc_todo/domain/data_provider/api_provider.dart';
import 'package:bloc_todo/domain/entities/todo.dart';

final todoApiProvider = TodoApiProvider();

class TodoApiProvider {
  // * APIs
  final apiGetTodos = '/api/v1/todo';
  final apiGetSingleTodo = '/api/v1/todo/'; // 'id'
  final apiCreateTodo = '/api/v1/todo';
  final apiUpdateTodo = '/api/v1/todo/'; // 'id'
  final apiDeleteTodo = '/api/v1/todo/'; // 'id'

  Future<List<Todo>> getTodos() async {
    final todos = await ApiProvider.GET(
      apiGetTodos,
      {},
    );

    if (todos != null) {
      return List<Todo>.from(
        json.decode(todos).map((x) => Todo.fromJson(x)),
      );
    } else {
      return const <Todo>[];
    }
  }

  Future<Todo>? getSingleTodo(String id) async {
    final todo = await ApiProvider.GET(
      apiGetSingleTodo,
      {'id': id},
    );

    if (todo != null) {
      return Todo.fromJson(jsonDecode(todo));
    } else {
      return Future.value(null);
    }
  }

  void updateTodo(Todo newTodo) async {
    await ApiProvider.PUT(
      apiUpdateTodo + newTodo.id!,
      newTodo.toJson(),
    );
  }

  Future<Todo> createTodo(Todo newTodo) async {
    final json = await ApiProvider.POST(
      apiCreateTodo,
      newTodo.toJson(),
    );

    return Todo.fromJson(jsonDecode(json!));
  }

  void deleteTodo(String id) async {
    await ApiProvider.DELETE(
      apiDeleteTodo + id,
      {},
    );
  }
}
