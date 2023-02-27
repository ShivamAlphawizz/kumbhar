import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:indianmilan/app/modules/My_profile/controllers/profile_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/list_model.dart';
import 'package:indianmilan/model/package_model.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_pages.dart';
import '../../../utils/ApiBaseHelper.dart';
import '../../../utils/image_helper.dart';

class profile_view_view extends StatefulWidget {
  UserModel model;


  profile_view_view(this.model);

  @override
  _profile_view_viewState createState() => _profile_view_viewState();
}

class _profile_view_viewState extends State<profile_view_view> {

  bool loadingVisit = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addVisitors();
    checkVisitors();
    getVisitor();
  }
  List<UserModel> visitList = [];
  getVisitor() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "matchesUser"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loadingVisit = false;
    });
   // setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          visitList.add(new UserModel.fromJson(v));
        });
      }
    } else {}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
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
        // title: Text("Profile details"),
        centerTitle: true,
        backgroundColor: Colors.transparent,

        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.centerLeft,
        //         end: Alignment.centerRight,
        //         colors: <Color>[Colors.blue, Colors.pink]),
        //   ),
        // ),

        actions: [
          GestureDetector(
            onTap: (){
              if(historyModel!=null){
                launch("tel://${widget.model.mobile}");
              }else{
                PrimeUpgrade(context);
              }

            },
            child: Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.wifi_calling_outlined,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(historyModel!=null){
                launch("https://meet.google.com/");
              }else{
                PrimeUpgrade(context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.videocam_outlined,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: (){
              if(widget.model.request.toString()=="0"){
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: 270,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15,top: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Container(
                                              height: 60,
                                              width: 60,
                                              child: commonImage(widget.model.userAvtar, 60.0, 60.0, "", context, PROFILE),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    child: Text(widget.model.name.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)
                                                ),

                                                Container(
                                                  margin: EdgeInsets.only(top: 2),
                                                  child: Text("${getString1(widget.model.city.toString())},${getString1(widget.model.state.toString())}",style: TextStyle(color: Colors.grey),),
                                                ),

                                              ],

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20,top: 10),
                                        alignment: Alignment.topRight,
                                        child: Icon(Icons.clear),
                                      ),
                                    ),

                                  ],

                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 15),
                                width: 370,
                                child: Text("This member hs chosen to receive Messages only from members she has Accepted their request",
                                  style: TextStyle(fontSize: 16),),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 15),
                                width: 370,
                                child: Text("initiate a conversation with her to get to know her response",
                                  style: TextStyle(fontSize: 16,color: Colors.red),),
                              ),

                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  addConnect();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.red,
                                  ),
                                  alignment: Alignment.center,
                                  height: 45,
                                  width: 130,
                                  child: Text("Connect Now",style: TextStyle(color: Colors.white,fontSize: 16),),
                                ),
                              )

                            ],
                          ),
                        ),
                      );
                    }
                );
              }else{
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(2)), (route) => false);
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.chat_outlined,
                color: Colors.white,
              ),
            ),
          )
        ],

        // leading:Container(
        //   child: Image.asset("images/backicon_indianmilan.png"),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: getHeight(600),
                    width: MediaQuery.of(context).size.width,
                    // AssetImage("Image_Shortlist_prifile/saree.png"),
                    child: commonImage(widget.model.userAvtar.toString(), MediaQuery.of(context).size.height / 1.5, MediaQuery.of(context).size.width, "", context, Girls)),
                Positioned(
                  bottom: 20,
                    right:0 ,
                    child: InkWell(
                      onTap: (){
                        if(widget.model.shortlisted.toString()=="1"){
                          setSnackbar("Already Shorted", context);
                        }else{
                          setState(() {
                            loading = true;
                          });
                          addShort();
                        }
                      },
                      child: !loading?Container(
                  decoration: BoxDecoration(
                      color: widget.model.shortlisted.toString()=="1"?Colors.red:Colors.yellow,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      )
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Image.asset(white_heart,height: 20,color: widget.model.shortlisted.toString()=="1"?Colors.white:Colors.yellow,),
                        ),
                        SizedBox(width: 5,),
                        text("Short List",fontWeight: FontWeight.w700,fontSize: 14.0,textColor: widget.model.shortlisted.toString()=="1"?Colors.white:Colors.black),
                      ],
                  ),
                ):loadingWidget(
                        color: Colors.red,
                      ),
                    ))

              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
              elevation: 15,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                      child: Row(
                        children: [
                          Text("About ",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          Text(getString1(widget.model.name.toString()),
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.roboto(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 5,
                        bottom: 10,
                      ),
                      child: Text(
                          getString1(widget.model.aboutMe.toString()),
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              height: 1.4,
                              fontWeight: FontWeight.normal,
                              fontSize: 14)),
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
              elevation: 15,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                      child: Text("Basic Details ",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                right: 10, left: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.redAccent[100],
                                borderRadius: BorderRadius.circular(30)),
                            margin: EdgeInsets.only(
                              left: 5,
                              right: 10,
                              top: 5,
                              bottom: 10,
                            ),
                            child: Text("Created by ${getString1(widget.model.profileFor.toString())}",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 7.sp)),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.redAccent[100],
                                borderRadius: BorderRadius.circular(30)),
                            margin: EdgeInsets.only(
                              left: 5,
                              right: 5,
                              top: 5,
                              bottom: 10,
                            ),
                            child: Text("${getString1(widget.model.age.toString())} year old",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 7.sp)),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.redAccent[100],
                                borderRadius: BorderRadius.circular(30)),
                            margin: EdgeInsets.only(
                              left: 5,
                              top: 5,
                              bottom: 10,
                            ),
                            child: Text("Height ${getString1(widget.model.height.toString())}",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 7.sp)),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange[100]),
                                  child: Icon(
                                    Icons.perm_contact_calendar_outlined,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Birth Date",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text(getString1(widget.model.dob.toString()),
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange[100]),
                                  child: Icon(
                                    Icons.receipt,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Reilgion & language",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text("${getString1(widget.model.caste.toString())}, ${getString1(widget.model.language.toString())}",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange[100]),
                                  child: Icon(
                                    Icons.people_alt_sharp,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Community",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text(getString1(widget.model.community.toString()),
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange[100]),
                                  child: Icon(
                                    Icons.location_on_sharp,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Location",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text("${getString1(widget.model.city.toString())}, ${getString1(widget.model.state.toString())}",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                           /* Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange[100]),
                                  child: Icon(
                                    Icons.perm_contact_calendar_outlined,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Birth Date",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text("29/09/2022",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),*/
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange[100]),
                                  child: Icon(
                                    Icons.restaurant_menu,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Diet Preferences",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text(getString1(widget.model.dietary.toString()),
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
              elevation: 15,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Profile Verification ",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  Verify,
                                  height: 25,
                                  width: 25,
                                ),
                                Text("Verified",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.roboto(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            approve,
                            height: 35,
                            width: 35,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("Mobile Number has been Verified",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
              elevation: 15,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Contact Details ",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                king,
                                height: 35,
                                width: 35,
                              ))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.red[100]),
                          child: Icon(
                            Icons.call,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Contact No.",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.roboto(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10)),
                              Text(showDetails?"+91 ${widget.model.mobile.toString()}":"+91 ${widget.model.mobile.toString().substring(0,5)}******",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14)),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, bottom: 10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.red[100]),
                          child: Icon(
                            Icons.email,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 5, bottom: 5, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Email ID",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.roboto(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10)),
                              Text(showDetails?"${widget.model.email.toString()}":"******@gmail.com",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14)),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            if(historyModel!=null){
                              setState(() {
                                showDetails = true;
                              });
                            }else{
                              PrimeUpgrade(context);
                            }

                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            margin: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[
                                      Colors.red,
                                      Colors.redAccent,
                                      Colors.lightGreenAccent
                                    ]),
                                borderRadius: BorderRadius.circular(30)),
                            alignment: Alignment.center,
                            child: Text("View Detail",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
              elevation: 15,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                      child: Text("Family Details",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 5,
                        bottom: 10,
                      ),
                      child: Text(
                          "Lorem ipsum dolor sit amet, consetetur sadipsuling elitr, sed diam nonumy eiromod tempor  Lorem ipsum dolor sit amet, consetetur sadipsuling elitr, sed diam nonumy eiromod tempor",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              height: 1.4,
                              fontWeight: FontWeight.normal,
                              fontSize: 14)),
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
              elevation: 15,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                      child: Text("Career & Education",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange[100]),
                                  child: Icon(
                                    Icons.perm_contact_calendar_outlined,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Qualification",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text(getString1(widget.model.qualification.toString()),
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange[100]),
                                  child: Icon(
                                    Icons.perm_contact_calendar_outlined,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Work As",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text(getString1(widget.model.occupation.toString()),
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            /*Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.greenAccent),
                                  child: Image.asset(
                                      "Image_Shortlist_prifile/Group 55731.png"),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Company Name",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text(getString1(widget.model.co.toString()),
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),*/
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange[100]),
                                  child: Icon(
                                    Icons.perm_contact_calendar_outlined,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Annual income",
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Text(getString1(widget.model.income.toString()),
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: 00, right: 00, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Text("Profile matching your interest",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => DashboardView(1)),
                              (route) => false);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Text("View All",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                  )
                ],
              ),
            ),
            !loadingVisit?visitList.length > 0
                ? Container(
              height: 210,
              margin: EdgeInsets.only(left: 10, top: 5),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: visitList.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile_view_view(visitList[index])));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            decoration: boxDecoration(
                                radius: 20,
                                color: Colors.grey,
                                showShadow: true),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: commonImage(visitList[index].userAvtar,
                                  150.0, 190.0, Girls, context, Girls),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    getString1(
                                        visitList[index].name.toString()),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1),
                                  child: Text(
                                      "${getString1(visitList[index].age.toString())}yrs | ${getString1(visitList[index].height.toString())}\n${getString1(visitList[index].city.toString())},${getString1(visitList[index].state.toString())}"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            )
                : Container(
              width: 150,
              height: getHeight(200),
              child: Center(
                  child: text("No Matches",
                      fontSize: 12.0,
                      fontFamily: fontMedium,
                      textColor: Colors.black,
                      fontWeight: FontWeight.w700)),
            ): Center(
              child: loadingWidget(),
            ),
            boxHeight(50),
          ],
        ),
      ),
      bottomSheet: checkStatus?Container(
          margin: EdgeInsets.only(top: 10),
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.red, Colors.yellow, Colors.pink]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text("Like her ?",  textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),
            /*  Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(30)

                ),
                child:Row(
                  children: [
                    Text("Skip  ",  textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    Icon(Icons.clear, color: Colors.white,size: 20,),
                  ],
                ),
              ),*/
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            height: 270,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15,top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                child: commonImage(widget.model.userAvtar, 60.0, 60.0, "", context, PROFILE),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      child: Text(widget.model.name.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.only(top: 2),
                                                    child: Text("${getString1(widget.model.city.toString())},${getString1(widget.model.state.toString())}",style: TextStyle(color: Colors.grey),),
                                                  ),

                                                ],

                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 20,top: 10),
                                          alignment: Alignment.topRight,
                                          child: Icon(Icons.clear),
                                        ),
                                      ),

                                    ],

                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: 370,
                                  child: Text("This member hs chosen to receive Messages only from members she has Accepted their request",
                                    style: TextStyle(fontSize: 16),),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: 370,
                                  child: Text("initiate a conversation with her to get to know her response",
                                    style: TextStyle(fontSize: 16,color: Colors.red),),
                                ),

                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                    if(historyModel!=null){
                                      addConnect();
                                    }else{
                                      PrimeUpgrade(context);
                                    }

                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.red,
                                    ),
                                    alignment: Alignment.center,
                                    height: 45,
                                    width: 130,
                                    child: Text("Connect Now",style: TextStyle(color: Colors.white,fontSize: 16),),
                                  ),
                                )

                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
                child: !loading?Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    children: [
                      Text("Connect  ",  textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Icon(Icons.check, color: Colors.black,size: 20,),

                    ],
                  ),
                ):Center(child: loadingWidget(color: Colors.white,),),
              )
            ],
          )
      ):SizedBox(),
    );
  }
  bool showDetails = false;
  PrimeUpgrade(context){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
             // height: MediaQuery.of(context).size.height/1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15,top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  child: commonImage(widget.model.userAvtar, 60.0, 60.0, "", context, PROFILE),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width/1.6,
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text("Upgrade to premium membership now to video call ${widget.model.name}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  )
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 20,top: 10),
                          alignment: Alignment.topRight,
                          child: Icon(Icons.clear),
                        ),
                      ],
                    ),),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 280,
                        width: 350,

                        child: Column(
                          children: [

                            Container(
                              margin: EdgeInsets.only(top: 10,left: 10),
                              alignment: Alignment.topLeft,
                              child: Text("Premium membership lets you",style: TextStyle(fontWeight: FontWeight.w700),),
                            ),

                            Container(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(top: 10,left: 10),
                                          child: Icon(Icons.call,color: Colors.green,),
                                        ),

                                        Container(
                                            margin: EdgeInsets.only(top: 10,left: 20),
                                            child:Text("Call her",style: TextStyle(color: Colors.grey,fontSize: 15),)
                                        ),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 10,right: 10),
                                    child: Icon(Icons.lock,color: Colors.grey,),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),

                            Container(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(top: 10,left: 10),
                                          child: Icon(Icons.video_call,color: Colors.green,),
                                        ),

                                        Container(
                                            margin: EdgeInsets.only(top: 10,left: 20),
                                            child:Text("Make video calls",style: TextStyle(color: Colors.grey,fontSize: 15),)
                                        ),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 10,right: 10),
                                    child: Icon(Icons.lock,color: Colors.grey,),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),

                            Container(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(top: 10,left: 10),
                                          child: Icon(Icons.message,color: Colors.green,),
                                        ),

                                        Container(
                                            margin: EdgeInsets.only(top: 10,left: 20),
                                            child:Text("Send personalised message",style: TextStyle(color: Colors.grey,fontSize: 15),)
                                        ),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 10,right: 10),
                                    child: Icon(Icons.lock,color: Colors.grey,),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),

                            Container(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(top: 10,left: 10),
                                          child: Icon(Icons.details,color: Colors.green,),
                                        ),

                                        Container(
                                            margin: EdgeInsets.only(top: 10,left: 20),
                                            child:Text("View all contact details",style: TextStyle(color: Colors.grey,fontSize: 15),)
                                        ),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 10,right: 10),
                                    child: Icon(Icons.lock,color: Colors.grey,),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),

                            Container(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(top: 10,left: 10),
                                          child: Icon(Icons.details,color: Colors.green,),
                                        ),

                                        Container(
                                            margin: EdgeInsets.only(top: 10,left: 20),
                                            child:Text("View all Hidden details",style: TextStyle(color: Colors.grey,fontSize: 15),)
                                        ),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 10,right: 10),
                                    child: Icon(Icons.lock,color: Colors.grey,),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(3)), (route) => false);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.red,
                      ),
                      alignment: Alignment.center,
                      height: 45,
                      width: 130,
                      child: Text("Upgrade Now",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
  bool loading = false;
  bool showWithdraw = false;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  addConnect() async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "user_id": curUserId.toString(),
        "requested_id": widget.model.userId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "sendInterest"), params);
      setState(() {
        loading = false;
      });
      if (response['status'].toString()=="1") {
        setSnackbar(response['message'], context);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }
  addShort() async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "user_id": curUserId.toString(),
        "short_listed_id": widget.model.userId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "shortlist"), params);
      setState(() {
        loading = false;
      });
      if (response['status'].toString()=="1") {
        setSnackbar(response['message'], context);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);

      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }
  bool checkStatus = false;
  addVisitors() async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "user_id": curUserId.toString(),
        "visitor_id": widget.model.userId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "addVisitors"), params);
      setState(() {
        loading = false;
      });
      if (response['status'].toString()=="1") {
        //setSnackbar(response['message'], context);
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);

      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }
  checkVisitors() async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "user_id": curUserId.toString(),
        "requested_id": widget.model.userId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "check_connect_api"), params);
      print(Uri.parse(baseUrl1 + "check_connect_api"));
      print(params);
      setState(() {
        loading = false;
      });
      if (response['status'].toString()=="1") {
        setState(() {
          checkStatus = false;
        });
        //setSnackbar(response['message'], context);
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);

      } else {
        setState(() {
          checkStatus = true;
        });
        //setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }
}

