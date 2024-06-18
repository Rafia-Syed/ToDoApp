import 'package:to_do_app/providers/to_do_provider.dart';
import 'package:to_do_app/todo_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> ToDoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ToDoHomeScreen(),
      ),
    );
  }
}