import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ToastHelper {
  // Fungsi statis untuk menampilkan toast
  static void show({
    required String message,
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.black,
    double fontSize = 16.0,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 2),
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
  }) {
    FToast fToast = FToast();
    fToast.init(Get.context!);

    fToast.showToast(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: backgroundColor,
        ),
        child: Text(
          message,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
      gravity: gravity,
      toastDuration: duration,
    );
  }
}
