import 'package:get/get.dart';

import '../controllers/Term_n_condition_controller.dart';

class Term_n_condition_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Term_n_condition_controller>(
      () => Term_n_condition_controller(),
    );
  }
}
