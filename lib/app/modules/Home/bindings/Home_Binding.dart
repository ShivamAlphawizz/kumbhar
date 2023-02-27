import 'package:get/get.dart';

import '../controllers/HomeNavigation.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeNavigation>(
      () => HomeNavigation(),
    );
  }
}
