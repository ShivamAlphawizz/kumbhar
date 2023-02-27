import 'package:get/get.dart';

import '../controllers/login.dart';

class loginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<loginController>(
      () => loginController(),
    );
  }
}
