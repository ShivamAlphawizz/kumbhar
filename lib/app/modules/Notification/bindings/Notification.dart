import 'package:get/get.dart';

import '../controllers/Notification_controller.dart';

class Notification_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Notification_controller>(
      () => Notification_controller(),
    );
  }
}
