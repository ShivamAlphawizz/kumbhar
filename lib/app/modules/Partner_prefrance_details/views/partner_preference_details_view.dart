import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:indianmilan/app/new_screen/update_preference.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/partner_model.dart';

class partner_preference_details_View extends StatefulWidget {
  const partner_preference_details_View({Key? key}) : super(key: key);

  @override
  _partnerpreferenceState createState() => _partnerpreferenceState();
}

class _partnerpreferenceState extends State<partner_preference_details_View> {
  bool loading = true;
  PartnerModel? partnerModel;

  TextEditingController qualificationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  getProfile() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "get_prefrence"), body: param, headers: {
      "Accept-Language": langCode,
    });
    print(res.body);
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      var v = response['data'][0];
      setState(() {
        partnerModel = new PartnerModel.fromJson(v);
      });
      // callChat();
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partner Preferences"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xffF72D2D), Color(0xffF5F049)]),
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.toNamed(Routes.Notofication_screen);
              },
              child: Container(
                margin: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                ),
              )),
        ],
        leading:GestureDetector(
          onTap:(){
            Navigator.pop(context);
          },
          child:   Container(
            padding: EdgeInsets.all(getWidth(20)),
            height: getHeight(50),
            width: getHeight(50),
            child: Image.asset(
              BACK_BUTTON,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: !loading
          ? partnerModel != null
              ? ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 22, top: 15, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Partner Basic Info",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdatePartner()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 00),
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    edit_profile,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20, top: 10),
                              // height: 400,
                              width: 350,

                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Age :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.age.toString())} years",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Height :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.height.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                /*  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Diet :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.d.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),*/
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Marital Status :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.martialStatus.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  /*Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Religion/Community :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.religion.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),*/
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Mother tounge :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.motherTongue.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Manglik :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.manglik.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Gotra :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.gotra.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Smoking :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.drinking.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Drinking :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.drinking.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 22, top: 15, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Partner Location",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20, top: 10),
                              // height: 400,
                              width: 350,

                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "State :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.state.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "City :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.city.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 22, top: 15, right: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Partner Education & Career",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20, top: 10),
                              // height: 400,
                              width: 350,

                              child: Column(
                                children: [
                                /*  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Qualification :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.q.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),*/
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Occupation :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.occuption.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Text(
                                              "Annual income :",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${getString1(partnerModel!.annualIncome.toString())}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UpdatePartner()));
        },
                child: Center(
                    child: Container(
                      decoration: boxDecoration(
                        bgColor: Colors.red,
                        radius: 10,
                      ),
                      padding: EdgeInsets.all(10),
                      child: text("Add Partner Preference",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white),
                    )),
              )
          : Center(
              child: loadingWidget(),
            ),
    );
  }
}
