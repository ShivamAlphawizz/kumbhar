import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class loginController extends GetxController {
  final count = 0.obs;
  var obscureNewPass = false.obs;

  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordcontroller =
  TextEditingController(text: "");

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
