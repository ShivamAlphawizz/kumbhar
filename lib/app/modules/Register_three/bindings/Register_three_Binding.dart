import 'package:get/get.dart';

import '../controllers/Register_three_cotroller.dart';

class Register_three_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Register_three_Controller>(
      () => Register_three_Controller(),
    );
  }
}
