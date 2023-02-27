import 'dart:convert';

import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indianmilan/app/modules/Notification/controllers/Notification_controller.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/notifcation_model.dart';
import 'package:http/http.dart' as http;

class Notifications_View extends StatefulWidget {
  const Notifications_View({Key? key}) : super(key: key);

  @override
  _Notifications_ViewState createState() => _Notifications_ViewState();
}

class _Notifications_ViewState extends State<Notifications_View> {
  List<NotificationModel> notifyList = [];
  bool loading = true;
  getUser() async {
    Map param = {};
    param['user_id'] = curUserId;
    //  param['type']= "0";
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "notification"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      notifyList.clear();
      loading = false;
    });
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        if (v['mystatus'] != "0") {
          setState(() {
            notifyList.add(new NotificationModel.fromJson(v));
          });
        } else {}
      }
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Notification"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.red, Colors.yellow]),
          ),
        ),

        /*actions: [
          GestureDetector(
            onTap:(){
              Get.toNamed(Routes.Deshboard_view_screen);
            },
            child: Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(Icons.home_outlined,color: Colors.white,),
            ),
          ),

        ],*/
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
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
          ? notifyList.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 00, bottom: 5),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: notifyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.only(
                              left: 20, right: 20, bottom: 10, top: 10),
                          elevation: 10,
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[100],
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Card(
                                  margin: EdgeInsets.all( 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  elevation: 2,
                                  child: model != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      child: commonImage(model!.userAvtar, 60.0,
                                          60.0, "", context, PROFILE),
                                    ),
                                  )
                                      : SizedBox(),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    boxHeight(15.0),
                                    Text(
                                      getString1(notifyList[index].title.toString()),
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    boxHeight(15.0),
                                    Text(
                                      getString1(notifyList[index].message.toString()),
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.roboto(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                    boxHeight(15.0),
                                    Row(
                                      children: [
                                        Container(
                                            height: 10,
                                            width: 10,
                                            child: Image.asset(
                                                remaining_time)),
                                        boxWidth(10),
                                        Text(
                                          getTime(notifyList[index].createdAt.toString()),
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Container(
                                //   margin: EdgeInsets.only(right: 5),
                                //   child: Icon(Icons.delete_outline_sharp,color: ColorValues.BUTTONBACKGROUND,),
                                // )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : Center(
                  child: text("No Notifications",
                      fontSize: 12.0,
                      fontFamily: fontMedium,
                      textColor: Colors.black,
                      fontWeight: FontWeight.w700))
          : Center(
              child: loadingWidget(),
            ),
    );
  }

  getTime(date){
    String temp = "";
    if(date!=""&&date!=null){
      int time = DateTime.now().difference(DateTime.parse(date.toString())).inHours;
      if(time > 0){
        return time.toString()+" hours ago";
      }else{
        time = DateTime.now().difference(DateTime.parse(date.toString())).inMinutes;
        return time.toString()+" minutes ago";
      }
    }
    return temp;
  }

}
