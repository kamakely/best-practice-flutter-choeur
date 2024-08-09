import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'config/theme/app_theme.dart';
import 'features/home/presentation/pages/home_screen.dart';

bool shouldUseFirebaseEmulator = false;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// The line `import 'package:firebase_core/firebase_core.dart';` in the Dart code is importing the
  /// `firebase_core` package in the Flutter project. This package is used for initializing Firebase
  /// services in a Flutter application.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  // final FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);

  // if (shouldUseFirebaseEmulator) {
  //   await auth.useAuthEmulator('localhost', 9099);
  // }

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
          initialRoute: '/',
          getPages: [
            // GetPage(
            //   name: '/login',
            //   page: () => const LoginScreen(),
            // ),
            GetPage(
              name: '/home',
              page: () => const HomeScreen(),
            )
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale('fr', 'FR'),
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
      child: const HomeScreen(),
    );
  }
}
