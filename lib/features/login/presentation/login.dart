import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/img/background.png'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(72.84),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 480,
                  
                  child:  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40.0,
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
                        const Gap(16),
                        const Text(
                          'description',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.gray700,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        const Gap(27),
                        TextField(
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          obscureText: false,
                        ),
                        const Gap(27),
                        TextField(
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          obscureText: true,
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // bottomNavigationBar: const LoginFooter(),
      ),
    );
  }
}
