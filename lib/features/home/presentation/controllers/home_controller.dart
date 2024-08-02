import 'package:chorale_fva/features/event/presentation/pages/event_screen.dart';
import 'package:chorale_fva/features/members/presentation/pages/members_screen.dart';
import 'package:chorale_fva/features/presence/presentation/pages/presence_screen.dart';
import 'package:chorale_fva/features/role/presentation/pages/role_screen.dart';
import 'package:chorale_fva/features/songs/presentation/pages/songs_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../../login/data/data_sources/local/auth_storage.dart';
import '../../../voices/presentation/pages/voices_screen.dart';
import '../../data/models/menu.dart';

class HomeController extends GetxController {
  final authStorage = AuthStorage();
  
  final List<Menu> menu = [
    Menu(name:  'Membres', onTap: () {
      Get.to(() => const MembersScreen());
    },),
    Menu(name:  'Présences', onTap: () {
      Get.to(() => const PresenceScreen());
    },),
    Menu(name:  'Voix', onTap: () {
      Get.to(() => const VoicesScreen());
    },),
    Menu(name:  'évenements', onTap: () {
      Get.to(() => const EventScreen());
    },),
    Menu(name:  'Responsabilités', onTap: () {
      Get.to(() => const RoleScreen());
    },),
    Menu(name:  'Chansons', onTap: () {
      Get.to(() => const SongsScreen());
    },),
  ];

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    super.onReady();
  }

  // Future<void> logout() async {
  //   authStorage.setIsAuthentificated(false);
  //   await FirebaseAuth.instance.signOut();
  //   Get.offAll(
  //     () => const LoginScreen(),
  //     transition: Transition.fadeIn,
  //     duration: Constants.animationDuration,
  //   );
  // }
}
