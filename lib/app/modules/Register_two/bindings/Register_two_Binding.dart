import 'package:get/get.dart';

import '../controllers/Register_two_cotroller.dart';

class Register_two_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Register_two_Controller>(
      () => Register_two_Controller(),
    );
  }
}
