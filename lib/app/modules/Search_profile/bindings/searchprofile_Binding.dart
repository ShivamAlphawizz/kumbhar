import 'package:get/get.dart';

import '../controllers/searchprofile_controller.dart';

class searchprofile_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<searchprofile_controller>(
      () => searchprofile_controller(),
    );
  }
}
