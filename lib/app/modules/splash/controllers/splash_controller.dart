import 'package:get/get.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/shared_prefrence/shared_preferences_singleton.dart';
import 'package:indianmilan/app/utils/shared_prefrence/shared_prefrences_constant.dart';


class SplashController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), navigateUser);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void navigateUser() async {
    String status = SharedPreferencesUtils.getBoolean(SDConstant.token).toString();
    print("status"+status);

    Get.offAllNamed(Routes.LOGIN_TYPE);
    // status.isNotEmpty && status!="false"
    //     ? Get.offAllNamed(Routes.LOGIN_TYPE)
    //     : Get.offAllNamed(Routes.WELCOME);
  }
}
