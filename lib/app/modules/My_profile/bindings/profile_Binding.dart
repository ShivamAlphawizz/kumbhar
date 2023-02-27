import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<profile_controller>(
      () => profile_controller(),
    );
  }
}
