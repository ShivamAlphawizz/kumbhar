import 'package:get/get.dart';

import '../controllers/Help_controller.dart';

class Help_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Help_controller>(
      () => Help_controller(),
    );
  }
}
