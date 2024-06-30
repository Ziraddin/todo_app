class Task {
  late String category;
  late String task;
  late bool checked;
  late String time;
  late String date;
  late String details;

  Task({
    required this.category,
    required this.task,
    required this.checked,
    required this.time,
    required this.date,
    required this.details,
  });

  static List<Task> fromJson({required List<Map<String, dynamic>> tasksJson}) {
    List<Task> taskList = [];
    try {
      for (var task in tasksJson) {
        taskList.add(
          Task(
            category: task["category"],
            task: task["task"],
            checked: task["checked"],
            time: task["time"],
            date: task["date"],
            details: task["details"],
          ),
        );
      }
    } catch (e) {
      throw ("No Task Found");
    }
    return taskList;
  }
}
