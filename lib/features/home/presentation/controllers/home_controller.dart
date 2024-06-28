import 'package:chorale_fva/features/login/presentation/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../login/data/data_sources/local/auth_storage.dart';

class HomeController extends GetxController {
  final authStorage = AuthStorage();
  final List<String> menu = [
    'Membres',
    'Présences',
    'Voix',
    'évenements',
    'Responsabilités',
    'Chansons',
  ];

  Future<void> logout() async {
    authStorage.setIsAuthentificated(false);
    await FirebaseAuth.instance.signOut();
    Get.offAll(
      () => const LoginScreen(),
      transition: Transition.fadeIn,
      duration: Constants.animationDuration,
    );
  }
}
