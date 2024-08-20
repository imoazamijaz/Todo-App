import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:todo_app/res/components/my_button.dart';
import 'package:todo_app/res/components/my_text_field.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/constants.dart';
import 'package:todo_app/res/size_box_extension.dart';
import 'package:todo_app/ui/bottom_nav/pending_tasks.dart';
import '../controller/task_controller.dart';
import '../model/task_model.dart';
import '../res/utils/utils.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final Task task;

  const EditTaskBottomSheet({super.key, required this.task});

  @override
  State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _dateController = TextEditingController(text: widget.task.date);
    _timeController = TextEditingController(text: widget.task.time);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

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


    final TaskController taskController = Get.find();
    final updatedTask = Task(
      id: widget.task.id,
      title: _titleController.text,
      description: _descriptionController.text,
      date: _dateController.text,
      time: _timeController.text,
      isCompleted: widget.task.isCompleted,
    );
    await taskController.updateTask(updatedTask);

    Get.offAll(const PendingTasks());
    Utils.successSnackBar('Task Updated');

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Get.height * 0.06),
          const Center(
            child: Text(
              'Edit Task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: MyColors.color
              ),
            ),
          ),
          26.kH,
          CustomTextField(
            controller: _titleController,
            label: 'Task Title',
          ),
          16.kH,
          CustomTextField(
            controller: _descriptionController,
            label: 'Task Description',
            maxLines: 3,
          ),
          16.kH,
          CustomTextField(
            controller: _dateController,
            label: 'Date',
            readOnly: true,
            onTap: () => _selectDate(context),
            suffixIcon: const Icon(Icons.calendar_month, color: MyColors.color),
          ),
          16.kH,
          CustomTextField(
            controller: _timeController,
            label: 'Time',
            readOnly: true,
            onTap: () => _selectTime(context),
            suffixIcon: const Icon(Icons.access_time, color: MyColors.color),
          ),
          26.kH,
          MyButton(
            width: double.infinity,
            onTap: _saveTask,
            text: 'Save Changes',
            isLoading: false,
          ),
        ],
      ),
    );
  }
}

void showEditTaskBottomSheet(BuildContext context, Task task) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        padding: padding,
        decoration:  BoxDecoration(
          color: MyColors.scaffoldSColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: EditTaskBottomSheet(task: task),
      );
    },
  );
}
