import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Utils {
  static void showPopinError(String error) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: TextStyle(
              color: Colors.white, fontFamily: 'Roboto', fontSize: 28.sp),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
          vertical: 16.h,
        ),
        backgroundColor: AppColors.red500,
      ),
    );
  }

  static void showPopinSuccess(String success) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(
          success,
          style: TextStyle(
              color: Colors.white, fontFamily: 'Roboto', fontSize: 28.sp),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
          vertical: 16.h,
        ),
        backgroundColor: AppColors.brandGreen600,
      ),
    );
  }
}
