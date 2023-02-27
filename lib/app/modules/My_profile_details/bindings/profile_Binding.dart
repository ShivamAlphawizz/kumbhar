import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class profile_view_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<profile_view_controller>(
      () => profile_view_controller(),
    );
  }
}
