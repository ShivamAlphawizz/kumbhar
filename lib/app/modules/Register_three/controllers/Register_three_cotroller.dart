import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Register_three_Controller extends GetxController {
  final count = 0.obs;
  var obscureNewPass = false.obs;
 // var items_party_type=['a','b','c','d'].obs;
  final items_party_type = <String>["a","b","c","d"].obs;
  String? selectedValue;

  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordcontroller = TextEditingController(text: "");


  TextEditingController dobCntroller = TextEditingController(text: "");

  DateTime currentDate = DateTime.now();

  DateTime get selectedDate =>
      DateTime(currentDate.year, currentDate.month, currentDate.day);
  DateFormat formatter = DateFormat('MMM dd, yyyy');







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
