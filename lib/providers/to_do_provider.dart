import 'package:to_do_app/models/todo_model.dart';
import 'package:to_do_app/database/db_helper.dart';
import 'package:flutter/material.dart';

class ToDoProvider extends ChangeNotifier {
   List<ToDoModel> _toDoList = [];

  List<ToDoModel> get toDoList => _toDoList;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ToDoProvider() {
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final tasks = await _databaseHelper.getTasks();
    print('Fetched tasks: $tasks');
    _toDoList = tasks.map((task) => ToDoModel.fromMap(task)).toList();
    notifyListeners();
  }

  Future<void> addToDo(ToDoModel task) async {
    await _databaseHelper.insertTask(task.toMap());
    await _fetchTasks();
  }

  Future<void> updateToDo(ToDoModel task) async {
    await _databaseHelper.updateTask(task.toMap());
    await _fetchTasks();
  }

  Future<void> deleteToDo(int id) async {
    await _databaseHelper.deleteTask(id);
    await _fetchTasks();
  }
}