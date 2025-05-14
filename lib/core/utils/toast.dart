import 'package:apptest/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';

class Toasts {
  static show(String message,
      {Color? color, Color? textColor, ToastGravity? gravity}) {
    Fluttertoast.showToast(
        msg: message,
        fontSize: 15.sp,
        gravity: gravity ?? ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: color ?? AppColors.white,
        textColor: textColor ?? AppColors.errorColor);

    Future.delayed(Duration(milliseconds: 1500), () {
      Fluttertoast.cancel();
    });
  }

  static showSnackbar(String message, Function() onPressed) {
    var snackBar = SnackBar(
        duration: const Duration(seconds: 4),
        content: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Text(
                  message,
                  style: fw400.copyWith(
                      color: AppColors.errorColor, fontSize: 13.sp),
                ),
              ],
            )),
            TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(navigatorKey.currentContext!)
                      .hideCurrentSnackBar();
                  onPressed();
                },
                child: Text(
                  'Retry',
                  style: fw400.copyWith(
                    color: AppColors.white,
                  ),
                ))
          ],
        ));
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }
}
