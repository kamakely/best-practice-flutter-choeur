import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:chorale_fva/features/login/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    
    
    
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 98, 217, 247),
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
                const Gap(20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * .95,
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 27.0,
                        horizontal: 20.0,
                      ),
                      child: Column(children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.brandBlue900,
                            fontWeight: FontWeight.w500,
                            fontSize: 36,
                          ),
                        ),
                        const Gap(27),
                        TextField(
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          controller: controller.loginController,
                          decoration: const InputDecoration(hintText: 'Email'),
                          obscureText: false,
                        ),
                        const Gap(27),
                        TextField(
                          controller: controller.passwordController,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration:
                              const InputDecoration(hintText: 'Mot de passe'),
                          obscureText: true,
                        ),
                        const Gap(27),
                        ElevatedButton(
                          onPressed: () {
                            
                          },
                          child: const Text(
                            'Connexion',
                          ),
                        )
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
