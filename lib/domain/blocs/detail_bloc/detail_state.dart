import 'package:bloc_todo/domain/entities/todo.dart';

enum DState {read, edit, create }

class DetailState {
  DState? detailState;
  Todo? todo;

  DetailState(); 
}