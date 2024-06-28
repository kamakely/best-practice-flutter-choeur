import 'package:chorale_fva/features/home/presentation/pages/home_screen.dart';
import 'package:chorale_fva/framework/utils.dart';
import 'package:chorale_fva/framework/utils/logger_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../data/data_sources/local/auth_storage.dart';
import '../../data/data_sources/remote/login_services.dart';

class LoginController extends GetxController {
  var isObscured = true.obs;
  var isLoading = false.obs;

  // The login and password text field controller
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final loginService = LoginService();

  var loginError = Rxn<String>();
  var passwordError = Rxn<String>();

  final authStorage = AuthStorage();

  @override
  void onInit() async {
    if (authStorage.getIsAuthentificated() == true) {
      navigateToHomeScreen();
    }
    FlutterNativeSplash.remove();
    super.onInit();
  }

  void handleIsObscured() => isObscured.value = !isObscured.value;

  void navigateToHomeScreen() {
    LoggerUtils.info('LoginController :: Go to the home page !!!');
    gotoPage(HomeScreen());
  }

  void gotoPage(Widget page) {
    Get.offAll(
      () => page,
      transition: Transition.fadeIn,
      duration: Constants.animationDuration,
    );
  }

  String? _validateField(String fieldValue) {
    return fieldValue.isEmpty ? 'Veuillez remplir ce champ' : null;
  }

  Future<void> handleLogin() async {
    isLoading.value = true;
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
        if (res == 'success') {
          authStorage.setIsAuthentificated(true);
          LoggerUtils.info(
              'Is authentificated: ${authStorage.getIsAuthentificated()}');
          Get.offAll(() => HomeScreen());
        } else {
          Utils.showPopinError(res ?? 'Veuillez vérifier votre connexion');
        }

        LoggerUtils.info(res ?? 'Result is null');
      } catch (e) {
        LoggerUtils.error('Login failed: $e');
        // Handle login error appropriately, e.g., show a message to the user
      }
    }
    isLoading.value = false;
  }
}
