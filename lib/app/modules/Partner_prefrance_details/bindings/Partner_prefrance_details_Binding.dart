import 'package:get/get.dart';

import '../controllers/Partner_prefrance_details_controller.dart';

class Partner_prefrance_details_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Partner_prefrance_details_controller>(
      () => Partner_prefrance_details_controller(),
    );
  }
}
