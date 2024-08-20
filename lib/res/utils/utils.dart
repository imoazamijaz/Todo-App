import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:get/get.dart';

class Utils {

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static Widget showLoaderDialog(BuildContext context, String message) {
    return AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: MyColors.color,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text(message),
            ),
          ),
        ],
      ),
    );
  }

  // we will utilise this for showing errors or success messages
  static successSnackBar(String message) {
    return Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.green,
    );
  }

  static errorSnackBar(String message) {
    return Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.red,
    );
  }


}


