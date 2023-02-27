import 'package:get/get.dart';

import '../controllers/OTP_login_cotroller.dart';

class OTP_login_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTP_login_Controller>(
      () => OTP_login_Controller(),
    );
  }
}
