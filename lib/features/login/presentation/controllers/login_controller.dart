import 'package:chorale_fva/features/home/presentation/pages/home.dart';
import 'package:chorale_fva/framework/utils.dart';
import 'package:chorale_fva/framework/utils/logger_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/data_sources/remote/login_services.dart';

class LoginController extends GetxController {
  var isObscured = true.obs;

  // The login and password text field controller
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final loginService = LoginService();

  var loginError = Rxn<String>();
  var passwordError = Rxn<String>();

  void handleIsObscured() => isObscured.value = !isObscured.value;

  String? _validateField(String fieldValue) {
    return fieldValue.isEmpty ? 'Veuillez remplir ce champ' : null;
  }

  Future<void> handleLogin() async {
    final loginErrorText = _validateField(loginController.text);
    final passwordErrorText = _validateField(passwordController.text);

    if (loginErrorText != null || passwordErrorText != null) {
      loginError.value = loginErrorText;
      passwordError.value = passwordErrorText;
    } else {
      loginError.value = null;
      passwordError.value = null;
      try {
        var res = await loginService.login(
          email: loginController.text,
          password: passwordController.text,
        );
        if (res == "success") {
          Get.offAll(() => const Home());
        } else {
          Utils.showPopinError(res ?? 'Veuillez vérifier votre connexion');
        }

        LoggerUtils.info(res ?? 'Result is null');
      } catch (e) {
        LoggerUtils.error('Login failed: $e');
        // Handle login error appropriately, e.g., show a message to the user
      }
    }
  }
}
