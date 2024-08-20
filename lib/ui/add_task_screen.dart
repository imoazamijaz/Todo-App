import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:todo_app/res/components/my_button.dart';
import 'package:todo_app/res/constants.dart';
import 'package:todo_app/res/size_box_extension.dart';
import 'package:todo_app/res/utils/utils.dart';
import '../controller/task_controller.dart';
import '../model/task_model.dart';
import '../res/colors.dart';
import '../res/components/my_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final TaskController taskController = Get.find();

  RxBool isLoading = false.obs;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  void _saveTask() async {
    if (_taskTitleController.text.isEmpty || _dateController.text.isEmpty || _timeController.text.isEmpty) {
      Utils.errorSnackBar('Please fill in all fields');
      return;
    }

    setState(() {
      isLoading.value = true;
    });

    final newTask = Task(
      title: _taskTitleController.text,
      description: _taskDescriptionController.text,
      date: _dateController.text,
      time: _timeController.text,
      isCompleted: 0,
    );

    await taskController.addTask(newTask);

    setState(() {
      isLoading.value = false;
    });

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldSColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.scaffoldSColor,
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: padding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your task details:',
                style: TextStyle(fontSize: 18.0),
              ),
              20.kH,
              CustomTextField(
                controller: _taskTitleController,
                label: 'Task Title',
              ),
              20.kH,
              CustomTextField(
                controller: _taskDescriptionController,
                label: 'Task Description',
                maxLines: 3,
              ),
              20.kH,
              CustomTextField(
                controller: _dateController,
                label: 'Date',
                readOnly: true,
                onTap: () => _selectDate(context),
                suffixIcon: const Icon(Icons.calendar_month,color: MyColors.color),
              ),
              20.kH,
              CustomTextField(
                controller: _timeController,
                label: 'Time',
                readOnly: true,
                onTap: () => _selectTime(context),
                suffixIcon: const Icon(Icons.access_time,color: MyColors.color),
              ),
              20.kH,
              Obx(() => MyButton(
                onTap: _saveTask,
                text: isLoading.value ? 'Saving...' : 'Save Task',
                isLoading: isLoading.value,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
