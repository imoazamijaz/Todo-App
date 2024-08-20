import 'package:flutter/material.dart';
import '../colors.dart';

class MyButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final bool isLoading;
  final double width;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double padding;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.isLoading,
    this.width = double.infinity, this.color = MyColors.color, this.textColor = Colors.white, this.borderColor = Colors.transparent,  this.padding = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor)
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
