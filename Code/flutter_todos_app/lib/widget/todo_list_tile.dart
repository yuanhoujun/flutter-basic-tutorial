import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodoListTile extends StatelessWidget {
  final Key itemKey;
  final Todo todo;
  final VoidCallback onTap;
  final Function(bool) onChanged;
  final VoidCallback onDisismissed;

  const TodoListTile(
      {super.key,
      required this.itemKey,
      required this.todo,
      required this.onTap,
      required this.onChanged,
      required this.onDisismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: itemKey,
        onDismissed: (direction) {
          onDisismissed.call();
        },
        background: Container(
            alignment: Alignment.centerRight,
            color: Colors.red,
            child: Icon(Icons.delete, color: Colors.grey)),
        // direction: DismissDirection.endToStart,
        child: ListTile(
          onTap: onTap,
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) {
              if (value != null) {
                onChanged.call(value);
              }
            },
          ),
          title: Text(todo.title,
              style: TextStyle(
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null)),
          subtitle: Text(todo.description),
          trailing: Icon(Icons.arrow_forward_ios),
        ));
  }
}
