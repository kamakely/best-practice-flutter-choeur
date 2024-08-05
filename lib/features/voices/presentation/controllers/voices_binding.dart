import 'package:get/get.dart';

import 'voices_controller.dart';

class VoicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      VoicesController(),
    );
  }
}
