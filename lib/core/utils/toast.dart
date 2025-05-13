import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_colors.dart';

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
}
