import 'package:get/get.dart';

import '../controllers/Register_five_cotroller.dart';

class Register_five_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Register_five_Controller>(
      () => Register_five_Controller(),
    );
  }
}
