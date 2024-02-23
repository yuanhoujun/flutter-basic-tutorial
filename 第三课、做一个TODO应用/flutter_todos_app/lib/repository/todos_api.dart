import 'package:flutter_todos_app/model/todo.dart';

abstract class TodosApi {
  Future<bool> add(Todo todo);

  Future<bool> delete(String id);

  Future<bool> markAllAsCompleted();

  Future<bool> clearCompleted();

  Future<List<Todo>> getTodos();
}
