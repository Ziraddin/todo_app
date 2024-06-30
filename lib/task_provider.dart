import 'package:flutter/material.dart';
import 'package:todo_app/data.dart';
import 'task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = Task.fromJson(tasksJson: tasksJson);

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTaskStatus(int index, bool checked) {
    _tasks[index].checked = checked;
    notifyListeners();
  }

  List<Task> getCompletedTasks() {
    var list = <Task>[];
    for (var task in tasks) {
      if (task.checked) {
        list.add(task);
      }
    }
    return list;
  }

  List<Task> getUnCompletedTasks() {
    var list = <Task>[];
    for (var task in tasks) {
      if (!task.checked) {
        list.add(task);
      }
    }
    return list;
  }
}
