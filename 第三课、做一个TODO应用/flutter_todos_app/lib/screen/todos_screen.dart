import 'package:flutter/material.dart';
import 'package:flutter_todos_app/model/todos_filter_option.dart';
import 'package:flutter_todos_app/model/todos_option.dart';
import 'package:flutter_todos_app/repository/local_repository.dart';
import 'package:flutter_todos_app/widget/todo_list_tile.dart';
import 'package:flutter_todos_app/widget/todos_filter_button.dart';
import 'package:flutter_todos_app/widget/todos_option_button.dart';

import '../model/todo.dart';
import 'edit_todo_screen.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() {
    return _TodosScreenState();
  }
}

class _TodosScreenState extends State<TodosScreen> {
  final List<Todo> _todos = [];
  final _todosApi = LocalRepository();
  TodosChangedListener? _todosChangedListener;
  TodosFilterOption _filterOption = TodosFilterOption.all;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    final todos = await _todosApi.getTodos();
    setState(() {
      _todos.addAll(todos);
    });

    _todosChangedListener = (todos) {
      setState(() {
        _todos.clear();
        _todos.addAll(todos);
      });
    };
    _todosApi.addTodosChangedListener(_todosChangedListener!);
  }

  List<Todo> _filterTodos(List<Todo> todos) {
    switch (_filterOption) {
      case TodosFilterOption.all:
        return todos;
      case TodosFilterOption.active:
        return todos.where((todo) => !todo.isCompleted).toList();
      case TodosFilterOption.completed:
        return todos.where((todo) => todo.isCompleted).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final todos = _filterTodos(_todos);

    return Scaffold(
        appBar: AppBar(
          title: Text("任务列表"),
          backgroundColor: Colors.blue,
          actions: [
            TodosFilterButton(
              selectedFilterOption: _filterOption,
              onSelected: (value) {
                setState(() {
                  _filterOption = value;
                });
              },
            ),
            TodosOptionButton(onSelected: (option) {
              _onOptionSelected(option);
            })
          ],
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoListTile(
                  itemKey: Key(todo.id),
                  todo: todo,
                  onDisismissed: () {
                    _todosApi.delete(todo.id);
                  },
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditTodoScreen(todo: todo);
                    }));
                  },
                  onChanged: (value) {
                    _updateTodoCompleteStatus(todo, value);
                  });
            }));
  }

  void _onOptionSelected(TodosOption option) {
    if (option == TodosOption.markAllAsCompleted) {
      _todosApi.markAllAsCompleted();
    } else if (option == TodosOption.clearCompleted) {
      _todosApi.clearCompleted();
    }
  }

  void _updateTodoCompleteStatus(Todo todo, bool isCompleted) {
    final newTodo = todo.copyWith(isCompleted: isCompleted);
    _todosApi.update(newTodo);
  }

  @override
  void dispose() {
    if (_todosChangedListener != null) {
      _todosApi.removeTodosChangedListener(_todosChangedListener!);
      _todosChangedListener = null;
    }
    super.dispose();
  }
}
