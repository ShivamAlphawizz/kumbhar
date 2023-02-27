import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static show(String text) {
    Fluttertoast.showToast(
        msg: text,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[200],
        textColor: Colors.black,
        fontSize: 15.0);
  }
}
