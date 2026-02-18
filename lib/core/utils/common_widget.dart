import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labamu/core/utils/constants.dart';

class CommonWidget {
  static AppBar appBar(
    BuildContext context,
    String title,
    IconData? backIcon,
    Color color, {
    void Function()? callback,
  }) {
    return AppBar(
      leading: backIcon == null
          ? null
          : IconButton(
              icon: Icon(backIcon, color: color),
              onPressed: () {
                if (callback != null) {
                  callback();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
      centerTitle: true,
      title: Text(title),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  static SizedBox rowHeight({double height = 30}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = 30}) {
    return SizedBox(width: width);
  }

  static void toast({
    required String message,
    Color color = green,
    Color textColor = Colors.white,
  }) async {
    Get.snackbar(
      "",
      message,
      backgroundColor: color,
      colorText: textColor,
      titleText: Container(),
    );
  }

  static void toastError(String error) async {
    Get.snackbar(
      "",
      error,
      backgroundColor: red,
      colorText: Colors.white,
      titleText: Container(),
    );
  }
}
