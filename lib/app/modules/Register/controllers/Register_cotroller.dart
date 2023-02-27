import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final count = 0.obs;
  var obscureNewPass = false.obs;
 // var items_party_type=['a','b','c','d'].obs;
  final items_party_type = <String>["a","b","c","d"].obs;
  String? selectedValue;

  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordcontroller = TextEditingController(text: "");

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
