import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Partner_preference_Controller extends GetxController {
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



  selectDatedialog(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate:
      DateTime(currentDate.year, currentDate.month, currentDate.day + 1),
      firstDate: DateTime(1950, 01, 01),
      /*theme: ThemeData(
        primaryColor: Colors.grey.shade100,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Theme.of(context).primaryColor),
          caption: TextStyle(color: Theme.of(context).primaryColor),
        ),
        primarySwatch: Colors.pink,


        accentColor: Theme.of(context).primaryColor,
        dialogBackgroundColor: Colors.grey.shade100,
        disabledColor: Colors.grey.shade400,
      ),*/
    );
    if (picked != null) dobCntroller.text = formatter.format(picked).toString();
  }



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
