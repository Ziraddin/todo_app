import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/color.dart';
import 'package:todo_app/task.dart';
import 'package:todo_app/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late double deviceHeight;
  late double deviceWidth;
  TextEditingController _dateContorller = TextEditingController();
  TextEditingController _timeContorller = TextEditingController();
  TextEditingController _titleContorller = TextEditingController();
  TextEditingController _notesContorller = TextEditingController();

  List<String> images = [
    "images/Category1.svg",
    "images/Category2.svg",
    "images/Category3.svg",
  ];
  List<bool> categoryColor = List.filled(3, false);

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.backgroundColor,
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            children: [
              Header(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TaskTitle(),
                        const SizedBox(
                          height: 40,
                        ),
                        Category(),
                        const SizedBox(
                          height: 40,
                        ),
                        DateTimeWidget(),
                        const SizedBox(
                          height: 40,
                        ),
                        NotesWidget(),
                        const SizedBox(
                          height: 40,
                        ),
                        SaveButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Header() {
    return SizedBox(
      width: deviceWidth,
      height: deviceHeight / 8,
      child: Stack(
        children: [
          SizedBox(
            width: deviceWidth,
            height: deviceHeight,
            child: SvgPicture.asset(
              "images/Header2.svg",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 10,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Add New Task",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget TaskTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Task Title",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: _titleContorller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.textFieldBorderColor,
              ),
            ),
            hintText: "Task Title",
          ),
        ),
      ],
    );
  }

  Widget Category() {
    return SizedBox(
      width: deviceWidth,
      height: 50,
      child: Row(
        children: [
          const Text(
            "Category",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        for (int i = 0; i < categoryColor.length; i++) {
                          categoryColor[i] =
                              (index != i) ? false : !categoryColor[i];
                        }
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            categoryColor[index] ? Colors.green : Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SvgPicture.asset(
                      images[index],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 20,
                );
              },
              itemCount: images.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget DateTimeWidget() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Date",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _dateContorller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Date",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.iconColor,
                  ),
                ),
                onTap: selectDate,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Time",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _timeContorller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Time",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(
                    Icons.access_time_outlined,
                    color: AppColors.iconColor,
                  ),
                ),
                onTap: selectTime,
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateContorller.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(
        () {
          _timeContorller.text = picked.toString().split("(")[1];
          _timeContorller.text = _timeContorller.text
              .substring(0, _timeContorller.text.length - 1);
        },
      );
    }
  }

  Widget NotesWidget() {
    return SizedBox(
      width: deviceWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Notes",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            maxLines: 7,
            controller: _notesContorller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Notes",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget SaveButton() {
    return SizedBox(
      width: deviceWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor),
        onPressed: () {
          saveTask();
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "Save",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  void saveTask() {
    late String category;
    for (var i = 0; i < categoryColor.length; i++) {
      if (categoryColor[i] == true) {
        category = "images/Category${i + 1}.svg";
      }
    }

    if (_titleContorller.text.isNotEmpty &&
        _dateContorller.text.isNotEmpty &&
        _timeContorller.text.isNotEmpty &&
        _notesContorller.text.isNotEmpty &&
        category.isNotEmpty) {
      Task newTask = Task(
        task: _titleContorller.text,
        date: _dateContorller.text,
        time: _timeContorller.text,
        details: _notesContorller.text,
        checked: false,
        category: category,
      );
      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
    }
  }
}
