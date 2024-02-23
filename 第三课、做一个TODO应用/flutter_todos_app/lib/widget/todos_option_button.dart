import 'package:flutter/material.dart';

import '../model/todos_option.dart';

class TodosOptionButton extends StatelessWidget {
  final Function(TodosOption) onSelected;

  const TodosOptionButton({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: onSelected,
        itemBuilder: (context) {
          return const [
            PopupMenuItem<TodosOption>(
                value: TodosOption.markAllAsCompleted, child: Text("标记全部完成")),
            PopupMenuItem<TodosOption>(
                value: TodosOption.clearCompleted, child: Text("清除已完成")),
          ];
        });
  }
}
