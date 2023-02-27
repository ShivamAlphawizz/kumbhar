import 'package:get/get.dart';

import '../controllers/login_type_controller.dart';

class login_typeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<login_typeController>(
      () => login_typeController(),
    );
  }
}
