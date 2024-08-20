import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/res/size_box_extension.dart';
import '../../controller/task_controller.dart';
import '../../res/colors.dart';
import '../../res/constants.dart';
import '../task_detail_screen.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Tasks')),
      body: Obx(() {
        final completedTasks = taskController.taskList
            .where((task) => task.isCompleted == 1)
            .toList();
        if (completedTasks.isEmpty) {
          return const Center(
            child: Text(
              'No completed tasks yet',
              style: TextStyle(fontSize: 18, color: MyColors.color),
            ),
          );
        } else {
          return Column(
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
                Text('Completed:  ', style: cardTitleStyle),
                Obx(() {
                  final completedTasks = taskController.taskList
                      .where((task) => task.isCompleted == 1)
                      .toList();
                  return Text(
                    '${completedTasks.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  );
                }),
              ],
            ),
          ),
              Expanded(
                child: ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = completedTasks[index];
                    return InkWell(
                      onTap: () {
                        Get.to(TaskDetailScreen(task: task, isPending: false,));
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Completed',
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
                                                  color: Colors.green.shade700,
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
