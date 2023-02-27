import 'package:get/get.dart';

import '../controllers/Shortlisted_Profile_controller.dart';

class Shortlisted_Profile_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Shortlisted_Profile_controller>(
      () => Shortlisted_Profile_controller(),
    );
  }
}
