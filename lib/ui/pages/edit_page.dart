import 'package:bloc_todo/domain/bloc/todo_bloc.dart';
import 'package:bloc_todo/domain/bloc/todo_event.dart';
import 'package:bloc_todo/domain/bloc/todo_state.dart';
import 'package:bloc_todo/domain/entities/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditPage extends StatelessWidget {
  static const id = '/edit_page';

  EditPage({Key? key}) : super(key: key);

  void onChange(value, BuildContext context) {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      context.read<SaveButtonBloc>().add(SaveButtonOnEvent());
    } else {
      context.read<SaveButtonBloc>().add(SaveButtonOffEvent());
    }
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Todo;
    final title = args.title;
    final desc = args.description;

    titleController.text = title;
    descriptionController.text = desc;

    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return BlocBuilder<SaveButtonBloc, SaveButtonState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Create Page'),
                actions: [
                  SaveButtonWidget(
                    oldTodo: args,
                    titleController: titleController,
                    descriptionController: descriptionController,
                  ),
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextField(
                    autofocus: true,
                    controller: titleController,
                    onChanged: (value) => onChange(value, context),
                    decoration: InputDecoration(
                      label: const Text('title'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    autofocus: true,
                    controller: descriptionController,
                    onChanged: (value) => onChange(value, context),
                    decoration: InputDecoration(
                      label: const Text('Description'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: null,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class SaveButtonWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Todo oldTodo;

  const SaveButtonWidget({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.oldTodo,
  }) : super(key: key);

  void saveTodo(BuildContext context) {

    final todo = Todo(
      id: oldTodo.id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      createdTime: DateFormat('dd-MM-yyyy  |  hh:mm:ss').format(DateTime.now()),
    );

    context.read<TodoBloc>().add(TodoEditEvent(todo));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = context.watch<SaveButtonBloc>().state.isEmpty;

    return TextButton(
      onPressed: isEmpty ? null : () => saveTodo(context),
      child: Text(
        'Edit',
        style: TextStyle(
          color: isEmpty ? Colors.white.withOpacity(0.4) : Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
