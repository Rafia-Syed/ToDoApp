import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/todo_model.dart';
import 'package:to_do_app/providers/to_do_provider.dart';

class ToDoInputBottomsheet extends StatefulWidget {
  final ToDoModel? task;
  const ToDoInputBottomsheet({super.key, this.task});

  @override
  State<ToDoInputBottomsheet> createState() => _ToDoInputBottomsheetState();
}

class _ToDoInputBottomsheetState extends State<ToDoInputBottomsheet> {
  late TextEditingController title;
  late TextEditingController description;
  late DateTime pickedDate;
  DateFormat formatter = DateFormat('dd-MM-yy');

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.task?.title ?? '');
    description = TextEditingController(text: widget.task?.description ?? '');
    pickedDate = widget.task != null
        ? DateFormat('dd-MM-yy').parse(widget.task!.dateTime)
        : DateTime.now();
  }

  selectDateTime() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023, 1, 1),
        lastDate: DateTime(2024, 12, 31));
    if (selectedDate != null) {
      setState(() {
        pickedDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.7,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: title,
              decoration: const InputDecoration(
                  hintText: "Enter Title", labelText: "Title"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: description,
              decoration: const InputDecoration(
                  hintText: "Enter Description", labelText: "Description"),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      selectDateTime();
                    },
                    child: const Text('Select Date')),
                Text(
                  formatter.format(pickedDate),
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ToDoModel model = ToDoModel(
                      id: widget.task?.id,
                      dateTime: formatter.format(pickedDate),
                      description: description.text,
                      title: title.text);

                  if (widget.task == null) {
                    context.read<ToDoProvider>().addToDo(model);
                  } else {
                    context.read<ToDoProvider>().updateToDo(model);
                  }
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
