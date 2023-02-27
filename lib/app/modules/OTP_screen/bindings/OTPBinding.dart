import 'package:get/get.dart';

import '../controllers/OTP_cotroller.dart';

class OTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTP_Controller>(
      () => OTP_Controller(),
    );
  }
}
