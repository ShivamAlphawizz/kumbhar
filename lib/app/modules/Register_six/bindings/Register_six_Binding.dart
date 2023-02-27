import 'package:get/get.dart';

import '../controllers/Register_six_cotroller.dart';

class Register_six_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Register_six_Controller>(
      () => Register_six_Controller(),
    );
  }
}
