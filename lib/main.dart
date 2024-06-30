import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add_task.dart';
import 'package:todo_app/task_provider.dart';
import 'package:todo_app/todo.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const TodoScreen(),
        '/addTask': (context) => const AddTaskScreen(),
      },
    );
  }
}
