import 'package:flutter/material.dart';
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
    width: 1,
  ),
);

final inputDecorationThemes = InputDecorationTheme(
    isDense: true,
    errorStyle: GoogleFonts.roboto(
      color: AppColors.red500,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    errorBorder: errorStyle,
    focusedErrorBorder: errorStyle,
    contentPadding: const EdgeInsets.all(16),
    enabledBorder: borderStyle,
    focusedBorder: borderStyle,
    labelStyle: const TextStyle(
        color: Color(0xFFC4C4C4), fontFamily: 'Roboto', fontSize: 20.0));
