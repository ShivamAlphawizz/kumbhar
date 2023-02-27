import 'package:get/get.dart';

import '../controllers/Upload_photo_cotroller.dart';

class Upload_photoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Upload_photo_Controller>(
      () => Upload_photo_Controller(),
    );
  }
}
