import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

const errorStyle = OutlineInputBorder(
    borderSide: BorderSide(
  color: AppColors.red500,
));

const borderStyle = OutlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.gray300,
    style: BorderStyle.solid,
  ),
);

final inputDecorationThemes = InputDecorationTheme(
    isDense: true,
    errorStyle: GoogleFonts.roboto(
      color: AppColors.red500,
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
    ),
    errorBorder: errorStyle,
    focusedErrorBorder: errorStyle,
    contentPadding: EdgeInsets.all(16.h),
    enabledBorder: borderStyle,
    focusedBorder: borderStyle,
    labelStyle: TextStyle(
        color: const Color(0xFFC4C4C4),
        fontFamily: 'Roboto',
        fontSize: 20.0.sp));
