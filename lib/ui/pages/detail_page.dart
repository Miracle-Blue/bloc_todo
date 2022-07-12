import 'package:bloc_todo/domain/blocs/detail_bloc/detail_bloc.dart';
import 'package:bloc_todo/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  static const id = '/detail_page';

  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(builder: (
      context,
      state,
    ) {
      final rougeArgs = ModalRoute.of(context)!.settings.arguments as RouteArgs;

      state.deatilState = rougeArgs.detailState;
      context.read<DetailBloc>().setTodo = rougeArgs.todo;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            if (state.deatilState == DState.read)
              IconButton(
                onPressed: () =>
                    context.read<DetailBloc>().pressedEdit(context),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              )
            else
              IconButton(
                onPressed: () =>
                    context.read<DetailBloc>().pressedSave(context),
                icon: const Icon(
                  Icons.check,
                  color: Colors.black,
                ),
              )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                readOnly: context.read<DetailBloc>().readOnly,
                autofocus: !context.read<DetailBloc>().readOnly,
                controller: context.read<DetailBloc>().titleController
                  ..text = rougeArgs.todo?.title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  hintText: "Title",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TextField(
                  readOnly: context.read<DetailBloc>().readOnly,
                  expands: true,
                  maxLines: null,
                  controller: context.read<DetailBloc>().descriptionController
                    ..text = rougeArgs.todo?.description ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Description",
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
