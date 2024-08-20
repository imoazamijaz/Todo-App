import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/constants.dart';
import 'package:todo_app/ui/bottom_nav/bottom_nav.dart';
import '../model/task_model.dart';
import '../controller/task_controller.dart';
import '../res/components/my_button.dart';
import '../res/utils/utils.dart';
import '../res/size_box_extension.dart';
import 'bottom_sheet.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  final bool isPending;

  const TaskDetailScreen({super.key, required this.task, required this.isPending});

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
        title: const Text(
          'Task Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Status',
                  style: headerStyle,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 2,
                        color: task.isCompleted == 1
                            ? Colors.green.shade700
                            : Colors.yellow.shade700,
                      )),
                  child: Text(
                    task.isCompleted == 1 ? 'Completed' : 'Pending',
                    style: const TextStyle(
                      fontSize: 15,
                      color: MyColors.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            12.kH,
            column(title: 'Name', subTitle: task.title),
            column(title: 'Date', subTitle: task.date),
            column(title: 'Time', subTitle: task.time),
            12.kH,
            Text(
              'Description',
              style: headerStyle,
            ),
            8.kH,
            Container(
              height: Get.height * 0.20,
              width: Get.width,
              padding: padding,
              decoration: decoration.copyWith(color: Colors.white),
              child: SingleChildScrollView(
                child: Text(
                  task.description,
                  style: const TextStyle(
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),

            const Spacer(),
            Visibility(
              visible: isPending,
              child: MyButton(
                onTap: showEditDraggableSheet,
                text: 'Edit',
                isLoading: false,
              ),
            ),
            16.kH,
            MyButton(
              onTap: () async {
                bool? confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Delete'),
                      content: const Text(
                          'Are you sure you want to delete this task?'),
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
                  Get.offAll(const BottomNav());
                  Utils.successSnackBar('Task Deleted');
                }
              },
              color: MyColors.scaffoldSColor,
              textColor: MyColors.color,
              borderColor: MyColors.color,
              text: 'Delete',
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget column({required String title, required String subTitle}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(
            subTitle,
            style: subStyle,
          ),
          const Divider(
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget myDivider() {
    return const Divider(
      color: Colors.white,
    );
  }
}
