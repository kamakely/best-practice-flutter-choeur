import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'config/theme/app_theme.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/login/presentation/pages/login_screen.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  app = await Firebase.initializeApp();
  auth = FirebaseAuth.instanceFor(app: app);

  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 9099);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1600),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          initialRoute: '/login',
          getPages: [
            GetPage(
              name: '/login',
              page: () => const LoginScreen(),
            ),
            GetPage(
              name: '/home',
              page: () => HomeScreen(),
            )
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
            inputDecorationTheme: inputDecorationThemes,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                      vertical: 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0.r),
                    ),
                    minimumSize: const Size.fromHeight(40),
                    backgroundColor: AppColors.brandBlue900,
                    foregroundColor: Colors.white)),
            buttonTheme: ButtonThemeData(
              padding: EdgeInsets.symmetric(
                horizontal: 28.w,
                vertical: 16.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              buttonColor: AppColors.brandBlue900,
            ),
            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: const LoginScreen(),
    );
  }
}
