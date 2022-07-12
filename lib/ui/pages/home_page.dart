import 'package:bloc_todo/domain/blocs/home_bloc/home_bloc.dart';
import 'package:bloc_todo/domain/entities/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const HomeLoadEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todosList.length,
            itemBuilder: (context, index) {
              return _TodoList(todo: state.todosList[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.read<HomeBloc>().openForCreate(context),
      ),
    );
  }
}

class _TodoList extends StatelessWidget {
  final Todo todo;

  const _TodoList({
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
        onTap: () => context.read<HomeBloc>().openForRead(
              context,
              todo,
            ),
        title: Text(
          todo.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          todo.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => context.read<HomeBloc>().add(
                    HomeDeleteEvent(todo),
                  ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => context.read<HomeBloc>().openForEdit(
                    context,
                    todo,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
