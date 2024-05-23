import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'config/theme/app_theme.dart';
import 'features/login/presentation/login.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: inputDecorationThemes,
        buttonTheme: ButtonThemeData(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            buttonColor: AppColors.brandBlue900,
          ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}


