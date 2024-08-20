import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/res/components/my_button.dart';
import 'package:todo_app/res/constants.dart';
import 'package:todo_app/res/size_box_extension.dart';
import 'package:todo_app/ui/task_detail_screen.dart';
import '../controller/task_controller.dart';
import '../res/colors.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: Column(
        children: [
          Container(
            padding: padding,
            margin: padding,
            width: Get.width,
            height: Get.height * 0.08,
            decoration: decoration,
            child: Row(
              children: [
                30.kW,
                Text('Pending:  ',style: cardTitleStyle),
                Obx(() {
                  final pendingTasks = taskController.taskList
                      .where((task) => task.isCompleted == 0)
                      .toList();
                  return Text(
                    '${pendingTasks.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  );
                }),
                const Spacer(),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.white,
                ),
                const Spacer(),
                Text('Completed:  ',style: cardTitleStyle),
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
                30.kW,
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (taskController.taskList.isEmpty) {
                return const Center(
                  child: Text(
                    'No tasks yet',
                    style: TextStyle(fontSize: 18, color: MyColors.color),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: taskController.taskList.length,
                  itemBuilder: (context, index) {
                    final task = taskController.taskList[index];
                    return InkWell(
                      onTap: () {
                        Get.to(TaskDetailScreen(task: task));
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
                                             Text(
                                              task.isCompleted == 1 ? 'Completed' : 'Pending',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            7.kW,
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: BoxDecoration(
                                                  color: task.isCompleted == 1
                                                      ? Colors.green.shade700
                                                      : Colors.yellow.shade700,
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
                                  // IconButton(
                                  //   icon: Icon(
                                  //     task.isCompleted == 1
                                  //         ? Icons.check_circle
                                  //         : Icons.radio_button_unchecked,
                                  //     color: task.isCompleted == 1
                                  //         ? Colors.green
                                  //         : Colors.grey,
                                  //   ),
                                  //   onPressed: () => taskController.toggleTaskStatus(task),
                                  // ),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: MyColors.color,
                                  )
                                ],
                              ),
                              25.kH,
                              MyButton(
                                onTap: () =>
                                    taskController.toggleTaskStatus(task),
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
