import 'package:get/get.dart';

import '../controllers/Your_cart_controller.dart';

class Your_cart_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Your_cart_controller>(
      () => Your_cart_controller(),
    );
  }
}
