import 'package:flutter_todos_app/model/todo.dart';
import 'package:flutter_todos_app/repository/todos_api.dart';

typedef TodosChangedListener = Function(List<Todo>);

class LocalRepository extends TodosApi {
  static final _instance = LocalRepository._();

  final List<Todo> _todos = [];
  final List<TodosChangedListener> _todosChangedListeners = [];

  LocalRepository._();

  factory LocalRepository() => _instance;

  @override
  Future<bool> add(Todo todo) async {
    _todos.add(todo);
    print("@@@@@@@${_todos.length}");
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  @override
  Future<bool> clearCompleted() async {
    _todos.removeWhere((todo) => todo.isCompleted);
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  @override
  Future<bool> delete(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  @override
  Future<List<Todo>> getTodos() async {
    return _todos;
  }

  @override
  Future<bool> markAllAsCompleted() async {
    final newTodos = _todos.map((e) => e.copyWith(isCompleted: true)).toList();
    _todos.clear();
    _todos.addAll(newTodos);
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  Future<bool> update(Todo todo) async {
    final index = _todos.indexWhere((element) => element.id == todo.id);
    if (index == -1) {
      return false;
    }

    _todos.removeWhere((e) => e.id == todo.id);

    if (index > _todos.length - 1) {
      _todos.add(todo);
    } else {
      _todos.insert(index, todo);
    }
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  void addTodosChangedListener(TodosChangedListener listener) {
    _todosChangedListeners.add(listener);
  }

  void removeTodosChangedListener(TodosChangedListener listener) {
    _todosChangedListeners.remove(listener);
  }
}
