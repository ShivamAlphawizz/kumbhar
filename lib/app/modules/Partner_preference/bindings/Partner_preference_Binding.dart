import 'package:get/get.dart';

import '../controllers/Partner_preference_cotroller.dart';

class Partner_preference_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Partner_preference_Controller>(
      () => Partner_preference_Controller(),
    );
  }
}
