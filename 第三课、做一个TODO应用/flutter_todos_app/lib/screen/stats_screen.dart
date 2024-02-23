import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../repository/local_repository.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() {
    return _TodosScreenState();
  }
}

class _TodosScreenState extends State<StatsScreen> {
  List<Todo> _todos = [];
  final _todosApi = LocalRepository();
  TodosChangedListener? _todosChangedListener;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final todos = await _todosApi.getTodos();
    setState(() {
      _todos = todos;
    });
    _todosChangedListener = (todos) {
      setState(() {
        _todos = todos;
      });
    };
    _todosApi.addTodosChangedListener(_todosChangedListener!);
  }

  @override
  Widget build(BuildContext context) {
    final completedTodosCount =
        _todos.where((todo) => todo.isCompleted).toList().length;
    final activeTodosCount = _todos.length - completedTodosCount;

    return Scaffold(
        appBar: AppBar(
          title: const Text("统计"),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            _StatItem(
                icon: const Icon(Icons.done),
                title: "已完成任务",
                value: completedTodosCount),
            _StatItem(
                icon: const Icon(Icons.circle),
                title: "激活中任务",
                value: activeTodosCount),
          ],
        ));
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

class _StatItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final int value;

  const _StatItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: 15),
          icon,
          const SizedBox(width: 10),
          Text(title),
          const Spacer(),
          Text(value.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
