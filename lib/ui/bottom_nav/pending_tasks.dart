import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/res/components/my_button.dart';
import 'package:todo_app/res/constants.dart';
import 'package:todo_app/res/size_box_extension.dart';
import 'package:todo_app/ui/task_detail_screen.dart';
import '../../controller/task_controller.dart';
import '../../model/task_model.dart';
import '../../res/colors.dart';
import '../add_task_screen.dart';

class PendingTasks extends StatefulWidget {
  const PendingTasks({super.key});

  @override
  State<PendingTasks> createState() => _PendingTasksState();
}

class _PendingTasksState extends State<PendingTasks> {
  final TaskController taskController = Get.put(TaskController());

  void _confirmCompleteTask(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to mark this task as done?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                taskController.toggleTaskStatus(task);
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Tasks')),
      body: Column(
        children: [
          Container(
            padding: padding,
            margin: padding,
            width: Get.width,
            height: Get.height * 0.08,
            decoration: decoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pending Task Count: ', style: cardTitleStyle),
                Obx(() {
                  final pendingTasks = taskController.taskList
                      .where((task) => task.isCompleted == 0)
                      .toList();
                  return Text(
                    '${pendingTasks.length}',
                    style: cardTitleStyle,
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              final pendingTasks = taskController.taskList
                  .where((task) => task.isCompleted == 0)
                  .toList();
              if (pendingTasks.isEmpty) {
                return const Center(
                  child: Text(
                    'No Pending Tasks yet',
                    style: TextStyle(fontSize: 18, color: MyColors.color),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: pendingTasks.length,
                  itemBuilder: (context, index) {
                    final task = pendingTasks[index];
                    return InkWell(
                      onTap: () {
                        Get.to(TaskDetailScreen(task: task, isPending: true,));
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Pending',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            7.kW,
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow.shade700,
                                                  shape: BoxShape.circle),
                                            )
                                          ],
                                        ),
                                        5.kH,
                                        Text(
                                          task.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: MyColors.color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              'Date: \n${task.date}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: Get.width * 0.17),
                                            Text(
                                              'Time: \n${task.time}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: MyColors.color,
                                  )
                                ],
                              ),
                              25.kH,
                              MyButton(
                                onTap: () => _confirmCompleteTask(task),
                                text: 'Done',
                                isLoading: false,
                                padding: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
