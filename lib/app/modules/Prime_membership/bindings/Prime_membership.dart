import 'package:get/get.dart';

import '../controllers/Prime_membership_controller.dart';

class Prime_membership_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Prime_membership_controller>(
      () => Prime_membership_controller(),
    );
  }
}
