import 'package:bloc_todo/domain/entities/todo.dart';

enum DState {read, edit, creat }

class DetailState {
  DState? deatilState;
  Todo? todo;

  DetailState(); 
}