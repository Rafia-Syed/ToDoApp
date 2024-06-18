import 'package:to_do_app/models/todo_model.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/to_do_provider.dart';
import 'package:to_do_app/todo_home_screen.dart';
import 'package:flutter/material.dart';

class ToDoListTile extends StatelessWidget {
  final ToDoModel modelData;
  const ToDoListTile({super.key, required this.modelData});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 90),
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 2),
                blurRadius: 0.1,
                spreadRadius: 1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                modelData.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                modelData.dateTime,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            modelData.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.blue),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Access the ToDoHomeScreen's context to call showToDoInputBottomsheet
                  final homeScreenContext = context.findAncestorStateOfType<ToDoHomeScreenState>();
                  homeScreenContext?.showToDoInputBottomsheet(task: modelData);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<ToDoProvider>().deleteToDo(modelData.id!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

}