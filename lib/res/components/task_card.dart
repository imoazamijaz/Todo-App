import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/constants.dart';
import 'package:todo_app/res/size_box_extension.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final Widget description;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.kH,
          description,  // Directly use Widget
        ],
      ),
    );
  }
}
