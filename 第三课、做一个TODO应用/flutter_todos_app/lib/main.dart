import 'package:flutter/material.dart';
import 'package:flutter_todos_app/screen/edit_todo_screen.dart';
import 'package:flutter_todos_app/screen/stats_screen.dart';
import 'package:flutter_todos_app/screen/todos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

enum HomeTab { todos, stats }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeTab _selectedTab = HomeTab.stats;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: IndexedStack(
          index: _selectedTab.index,
          children: const [TodosScreen(), StatsScreen()],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const EditTodoScreen();
              }));
            },
            child: const Icon(Icons.add)),
        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _HomeTabButton(
                    groupValue: _selectedTab,
                    value: HomeTab.todos,
                    icon: const Icon(Icons.list_rounded),
                    onPressed: () {
                      _switchTab(HomeTab.todos);
                    }),
                _HomeTabButton(
                    groupValue: _selectedTab,
                    value: HomeTab.stats,
                    icon: const Icon(Icons.show_chart_rounded),
                    onPressed: () {
                      _switchTab(HomeTab.stats);
                    })
              ],
            )));
  }

  void _switchTab(HomeTab homeTab) {
    if (_selectedTab == homeTab) return;

    setState(() {
      _selectedTab = homeTab;
    });
  }
}

class _HomeTabButton extends StatelessWidget {
  final HomeTab groupValue;
  final HomeTab value;
  final Icon icon;
  final VoidCallback onPressed;

  _HomeTabButton(
      {required this.groupValue,
      required this.value,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: icon,
        color: value == groupValue ? Colors.blue : Colors.grey);
  }
}
