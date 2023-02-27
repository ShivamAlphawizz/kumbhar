import 'package:get/get.dart';

import '../controllers/faqs_controller.dart';

class faqs_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<faqs_controller>(
      () => faqs_controller(),
    );
  }
}
