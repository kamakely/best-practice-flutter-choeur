import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:chorale_fva/features/login/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/login_binding.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    LoginBinding().dependencies();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xFFFFFFFF),
              Color(0xFF62D9F7),
            ])),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo-no-background.png',
                  width: MediaQuery.of(context).size.width * .7,
                ),
                Gap(20.h),
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  width: MediaQuery.of(context).size.width * .95,
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 27.0.h,
                        horizontal: 20.0.w,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.brandBlue900,
                                fontWeight: FontWeight.w500,
                                fontSize: 36.sp,
                              ),
                            ),
                            Obx(
                              () => TextField(
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                controller: controller.loginController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: const Icon(Icons.person),
                                  errorText: controller.loginError.value,
                                ),
                                obscureText: false,
                              ),
                            ),
                            Obx(
                              () => TextField(
                                controller: controller.passwordController,
                                onTapOutside: (event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: InputDecoration(
                                    hintText: 'Mot de passe',
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.handleIsObscured();
                                      },
                                      icon: Icon(
                                        controller.isObscured.value
                                            ? Icons.visibility
                                            : Icons.visibility_off_outlined,
                                      ),
                                    ),
                                    errorText: controller.passwordError.value),
                                obscureText: controller.isObscured.value,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await controller.handleLogin();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Connexion',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 28.sp),
                                  ),
                                  if (controller.isLoading.value) Gap(20.w),
                                  if (controller.isLoading.value)
                                    SizedBox(
                                        width: 20.h,
                                        height: 20.h,
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          strokeWidth: 1.h,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(Colors.white),
                                        ))
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: const LoginFooter(),
    );
  }
}
