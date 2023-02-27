import 'package:get/get.dart';

import '../controllers/Register_four_cotroller.dart';

class Register_four_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Register_four_Controller>(
      () => Register_four_Controller(),
    );
  }
}
