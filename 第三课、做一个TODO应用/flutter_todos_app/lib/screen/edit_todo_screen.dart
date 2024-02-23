import 'package:flutter/material.dart';
import 'package:flutter_todos_app/repository/local_repository.dart';
import 'package:uuid/uuid.dart';

import '../model/todo.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo? todo;

  const EditTodoScreen({super.key, this.todo});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  String? _title;
  String? _description;

  @override
  void initState() {
    super.initState();

    final todo = widget.todo;
    _title = todo?.title;
    _description = todo?.description;
  }

  @override
  Widget build(BuildContext context) {
    final todo = widget.todo;

    return Scaffold(
        appBar: AppBar(title: todo == null ? const Text("添加任务") : Text("编辑任务")),
        floatingActionButton: FloatingActionButton(
            onPressed: _title != null
                ? () {
                    if (todo == null) {
                      _addTask();
                    } else {
                      _editTask();
                    }
                  }
                : null,
            child: Icon(Icons.done)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _TitleField(
                initialValue: _title,
                hintText: todo?.title,
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              _DescriptionField(
                initialValue: _description,
                hintText: todo?.description,
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              )
            ],
          ),
        ));
  }

  void _addTask() {
    final todosApi = LocalRepository();
    final id = const Uuid().v4();
    final newTodo = Todo(
      id: id,
      title: _title ?? "",
      description: _description ?? "",
    );
    todosApi.add(newTodo);

    Navigator.pop(context, newTodo);
  }

  void _editTask() {
    final todo = widget.todo;
    if (todo == null) return;

    final todosApi = LocalRepository();
    final newTodo = todo.copyWith(
      title: _title,
      description: _description ?? "",
    );
    todosApi.update(newTodo);

    Navigator.pop(context, newTodo);
  }
}

class _TitleField extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final Function(String?)? onChanged;

  const _TitleField({this.initialValue, this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        maxLength: 50,
        maxLines: 1,
        decoration: InputDecoration(label: Text("标题"), hintText: hintText),
        onChanged: onChanged);
  }
}

class _DescriptionField extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final Function(String?)? onChanged;

  const _DescriptionField({this.initialValue, this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        maxLength: 300,
        maxLines: 7,
        decoration: InputDecoration(label: Text("描述"), hintText: hintText),
        onChanged: onChanged);
  }
}
