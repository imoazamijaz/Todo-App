import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/constants.dart';
import '../model/task_model.dart';
import '../controller/task_controller.dart';
import '../res/components/my_button.dart';
import '../res/utils/utils.dart';
import '../res/size_box_extension.dart';
import 'bottom_sheet.dart';
import 'home_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    void showEditDraggableSheet() async {
      final updatedTask = await showModalBottomSheet<Task>(
        enableDrag: true,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return EditTaskBottomSheet(task: task);
        },
      );

      if (updatedTask != null) {

        taskController.updateTask(updatedTask);
        Utils.successSnackBar('Task Updated');

      }
    }
    return Scaffold(
      backgroundColor: MyColors.scaffoldSColor,
      appBar: AppBar(
        backgroundColor: MyColors.scaffoldSColor,
        title: const Text('Task Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            8.kH,
            Text(
              task.isCompleted == 1 ? 'Status: Completed' : 'Status: Pending',
              style: TextStyle(
                fontSize: 18,
                color: task.isCompleted == 1 ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            8.kH,
            Text(
              'Date: ${task.date}',
              style: const TextStyle(fontSize: 18),
            ),
            8.kH,
            Text(
              'Time: ${task.time}',
              style: const TextStyle(fontSize: 18),
            ),
            8.kH,
            Text(
              'Description: ${task.description}',
              style: const TextStyle(fontSize: 18),
            ),
            16.kH,
            const Divider(
              color: Colors.white,
            ),
            const Spacer(),
            MyButton(
              onTap: showEditDraggableSheet,
              text: 'Edit',
              isLoading: false,
            ),
            16.kH,
            MyButton(
              onTap: () async {
                bool? confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Delete'),
                      content: const Text('Are you sure you want to delete this task?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
                if (confirm == true) {
                  await taskController.deleteTask(task.id!);
                  Get.offAll(const HomeScreen());
                  Utils.successSnackBar('Task Deleted');
                }
              },
              color: MyColors.scaffoldSColor,
              textColor: MyColors.color,
              borderColor:  MyColors.color,
              text: 'Delete',
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }
}
