import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/color.dart';
import 'package:todo_app/task.dart';
import 'package:todo_app/task_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String currentDate = DateFormat("d MMMM, yyyy").format(DateTime.now());
  late List<Task> tasks;
  late List<Task> completedTasks;
  late List<Task> uncompletedTasks;
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context);
    tasks = provider.tasks;
    completedTasks = provider.getCompletedTasks();
    uncompletedTasks = provider.getUnCompletedTasks();

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Header(
              context: context,
              currentDate: currentDate,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.only(top: 160),
              child: Column(
                children: [
                  Uncompleted(
                    tasks: uncompletedTasks,
                    context: context,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Uncompleted(
                    tasks: completedTasks,
                    context: context,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              alignment: Alignment.bottomCenter,
              width: deviceWidth,
              height: deviceHeight,
              child: TaskButton(),
            ),
          ],
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget TaskButton() {
    return Wrap(children: [
      SizedBox(
        width: deviceWidth,
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor),
          onPressed: () {
            Navigator.of(context).pushNamed(
              "/addTask",
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Add New Task",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.backgroundColor,
              ),
            ),
          ),
        ),
      ),
    ]);
  }

// ignore: non_constant_identifier_names
  Widget Uncompleted({
    required BuildContext context,
    required List<Task> tasks,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: deviceWidth,
        height: deviceHeight / 3.5,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey.withOpacity(0.4),
              ),
            ]),
        child: ListView.separated(
          itemCount: tasks.length,
          separatorBuilder: (context, index) {
            return Divider(
              color: AppColors.backgroundColor,
              height: 30,
            );
          },
          itemBuilder: (context, index) {
            bool checked = tasks[index].checked;
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    tasks[index].category,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    tasks[index].task,
                    style: tasks[index].checked
                        ? const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          )
                        : const TextStyle(
                            decoration: TextDecoration.none,
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Checkbox(
                    value: checked,
                    onChanged: (value) => {
                      Provider.of<TaskProvider>(context, listen: false)
                          .updateTaskStatus(index, value!)
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget Header({
    required context,
    required currentDate,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      width: deviceWidth,
      height: deviceHeight / 3.5,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Header.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentDate,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My Todo List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
