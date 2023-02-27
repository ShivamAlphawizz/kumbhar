import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /*-----------------SHYAM TRUST---------------------------*/
  static final String BASE_URL = "https://eyekandy.manageprojects.in/api/";

  static final String login = "faq";


  /* //sanbox
  static final String cftokengenerate =
      "https://test.cashfree.com/api/v2/cftoken/order";
  static final String APPLICATION_ID = "111004fd8c8e4a74cdebd5fb21400111";
  static final String SECRET_ID = "b5ed1f01151ebf4f7c03b60cd080b6d686202bc3";*/



  /*----------------EYE KANDY---------------------------*/

  Future Faq() async {
    final response = await http.get(
      Uri.parse(BASE_URL + login),
      headers: {HttpHeaders.acceptHeader: "application/json"},
    );
    var ConvertDataToJson = jsonDecode(response.body);
    return ConvertDataToJson;
  }


}
