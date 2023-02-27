import 'package:get/get.dart';

import '../controllers/privacy_policy_Navigation.dart';

class privacy_policyBinding extends Bindings {
  @override

  void dependencies() {
    Get.lazyPut<privacy_policy_Navigation>(
      () => privacy_policy_Navigation(),
    );
  }

}
