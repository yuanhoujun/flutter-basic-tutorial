import 'package:flutter/material.dart';
import 'package:flutter_todos_app/model/todos_filter_option.dart';

class TodosFilterButton extends StatelessWidget {
  final TodosFilterOption selectedFilterOption;
  final Function(TodosFilterOption) onSelected;

  const TodosFilterButton(
      {super.key,
      required this.selectedFilterOption,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        initialValue: selectedFilterOption,
        onSelected: onSelected,
        itemBuilder: (context) {
          return const [
            PopupMenuItem<TodosFilterOption>(
                value: TodosFilterOption.all, child: Text("所有")),
            PopupMenuItem<TodosFilterOption>(
                value: TodosFilterOption.active, child: Text("仅激活")),
            PopupMenuItem<TodosFilterOption>(
                value: TodosFilterOption.completed, child: Text("已完成")),
          ];
        },
        child: const Icon(Icons.filter_list_rounded));
  }
}
