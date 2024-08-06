import 'package:get/get.dart';

import 'events_controller.dart';

class EventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      EventsController(),
    );
  }
}
