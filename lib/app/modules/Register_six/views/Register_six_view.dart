import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/OTP_screen/views/OTP_view.dart';
import 'package:indianmilan/app/modules/Register_six/controllers/Register_six_cotroller.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/Session.dart';
import 'package:http/http.dart' as http;

import '../../Login/views/login_view.dart';
class Register_six_view extends StatefulWidget {
  var param;


  Register_six_view(this.param);

  @override
  _Register_six_viewState createState() => _Register_six_viewState();
}

class _Register_six_viewState extends State<Register_six_view> {
  bool toggle = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;
  Map param = {};


  Widget getTitle() {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      height: 40,
      width: 120,
      child: Image.asset(
        SPLASH_IMAGE,
        fit: BoxFit.fill,
      ),
    );
  }

  Container getBackButton() {
    return Container(
      padding: EdgeInsets.all(getWidth(20)),
      height: getHeight(50),
      width: getHeight(50),
      child: Image.asset(
        BACK_BUTTON,
        fit: BoxFit.fill,
      ),
    );
  }


  Row getHeader() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: getBackButton(),
        ),
        const Spacer(
          //flex: 1,
        ),
        getTitle(),
        const Spacer(flex: 2)
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (model != null) {
      if (model!.aboutMe != null && model!.aboutMe != "") {
        desCon.text = model!.aboutMe.toString();
      }
    }

    param = widget.param;
  }

  TextEditingController desCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("checking params here ${widget.param}            okokokokokokok");
    Size screenSize = MediaQuery
        .of(context)
        .size;
    // bool isScreenWide = MediaQuery.of(context).size.width >= kMinWidthOfLargeScreen;
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    beginWidth = Dimension.max(20.toPercentLength, 700.toPXLength);
    beginHeight = (90.toVHLength - 10.toPXLength);

    endWidth = Dimension.clamp(200.toPXLength, 40.toVWLength, 200.toPXLength);
    endHeight = 50.toVHLength +
        10.toPercentLength -
        Dimension.min(4.toPercentLength, 40.toPXLength);
    //LocalNotificationService.initialize(context);
    return
      SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: getBackButton(),
              ),
              centerTitle: true,
              title: getTitle(),
            ),
            backgroundColor: Colors.white,
            body:
            Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child:
                    Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 350.toPercentLength.value,
                          child: Image.asset(
                            LOGIN_BACKGRAUND,
                            fit: BoxFit.fill,
                          ),
                        ),

                      ],)

                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      boxHeight(95),
                      text("Great ! Now some basic details about you",
                          fontFamily: fontMedium,
                          fontSize: 12.sp,
                          textColor: Colors.white
                      ),
                      boxHeight(35),
                      Container(
                        width: getWidth(625),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            text("All Fields are mandatory",
                                fontFamily: fontMedium,
                                fontSize: 9.sp,
                                textColor: Color(0xffFECC2F)
                            ),
                          ],),
                      ),
                      boxHeight(15),
                      Container(
                        width: getWidth(625),
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(24), vertical: getHeight(40)),
                        decoration: boxDecoration(
                          radius: 20,
                          showShadow: true,
                          bgColor: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 2.8,
                              child: TextFormField(
                                minLines: 20,
                                maxLines: 50,
                                controller: desCon,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: MULTILINE_TEXT1,
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0)),
                                  ),
                                ),
                              ),
                            )
                          ],),
                      ),
                      boxHeight(90),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (desCon.text == "") {
                              setSnackbar("Please Enter Description", context);
                              return;
                            }
                            param['description'] = desCon.text;
                            print(param);
                            setState(() {
                              loading = true;
                            });
                            if (model != null) {
                              update();
                            } else {
                              register();
                            }
                          },
                          child: Container(
                            width: getWidth(625),
                            height: getHeight(95),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0, 1],
                                  colors: <Color>[
                                    Color(0xff4292EB),
                                    Color(0xff63BEF5),
                                  ]),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: !loading ? text(model != null
                                  ? "Update Profile"
                                  : Create_Profile,
                                  fontFamily: fontMedium,
                                  fontSize: 14.sp,
                                  textColor: Colors.white
                              ) : loadingWidget(color: Colors.white,),
                            ),
                          ),
                        ),
                      ),
                      boxHeight(200),
                    ],),
                )


              ],
            )
        ),
      );
  }

  bool loading = false;

  register() async {
    var headers = {
      'Cookie': 'ci_session=507e3907aab6a92f945e0bb184649ddb34510500'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}signup'));
    request.fields.addAll({
      'profile_for': '${param['profile_for']}',
      'first_name': '${param['first_name']}',
      'last_name': '',
      'gender': '${param['gender']}',
      'religion': '${param['religion']}',
      'community': '${param['community']}',
      'family_address': '${param['family_address']}',
      'email': '${param['email']}',
      'mobile': '${param['mobile']}',
      'password': '${param['password']}',
      'dob': '${param['dob']}',
      'birth_place': '${param['birth_place']}',
      'birth_time': '${param['birth_time']}',
      'country': '${param['country']}',
      'state': '${param['state']}',
      'city': '${param['city']}',
      'marital_status': '${param['marital_status']}',
      'caste': ' null',
      'sub_caste': '',
      'gotra': '${param['gotra']}',
      'dosh': '${param['dosh']}',
      'manglik': '${param['manglik']}',
      'language': '${param['language']}',
      'mother_tongue': '${param['mother_tongue']}',
      'physical_status': '${param['physical_status']}',
      'dietary': '${param['dietary']}',
      'height': '${param['height']}',
      'age': '${param['age']}',
      'weight': '${param['weight']}',
      'smoking': '${param['smoking']}',
      'drinking': '${param['drinking']}',
      'qualification': '${param['qualification']}',
      'occupation': '${param['occupation']}',
      'organisation_name': '${param['organisation_name']}',
      'designation': '${param['designation']}',
      'working': '${param['working']}',
      'income': '${param['income']}',
      'horoscope': '${param['horoscope']}',
      'nakchatra': '${param['nakchatra']}',
      'hobbies': '${param['hobbies']}',
      'device_type': '${param['device_type']}',
      'device_token': '${param['device_token']}',
      'pin': '${param['pin']}',
      'family_status': '${param['family_status']}',
      'family_type': '${param['family_type']}',
      'family_city': '${param['family_city']}',
      'family_value': '${param['family_value']}',
      'father_status': '${param['father_status']}',
      'father_name': '${param['father_name']}',
      'mother_name': '${param['mother_name']}',
      'family_state': '${param['family_state']}',
      'family_income': '${param['family_income']}',
      'mother_status': '${param['family_status']}',
      'brother_name': '${param['brother_name']}',
      'description': '${param['description']}',
      'no_brother': '${param['no_brother']}',
      'father_mobile': '${param['father_mobile']}',
      'grand_father_name': '${param['grand_father_name']}',
      'maternal_grand_father_name': 'sds',
      'no_sister': '${param['no_sister']}'
    });

    request.headers.addAll(headers);
    print("final parameters are here ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      print("final response here ${finalResponse} and");
      final jsonResponse = json.decode(finalResponse);
      setSnackbar("${jsonResponse['message']}", context);
      if (jsonResponse['status'] == 1 || jsonResponse['status'] == "1") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => login_view()));
     }
      else {
        setSnackbar("Somthing went wrong", context);
      }
    }
    else {
      print(response.reasonPhrase);
    }
    /////////////////////////////////
    //  print("final check here now ${param['profile_for']}");
    //  print("ok go now");
    //  param['name']= "test";
    //  param['sub_caste']= "test";
    //  param['brother_name']= "test";
    // param['device_token']= fcmToken;
    //
    //  var res = await http.post(Uri.parse("${baseUrl}signup"),body: param,headers: {
    //  "Accept-Language" : langCode,
    //  });
    //  Map response = jsonDecode(res.body);
    //  setState(() {
    //    loading = false;
    //  });
    //  setSnackbar(response['message'].toString(), context);
    //  if(response['status'].toString()=="1"){
    //    Navigator.push(context, MaterialPageRoute(builder: (context)=>OTP_view(param['mobile'])));
    //  }else{
    //  }
  }

  update() async {
    var headers = {
      'Cookie': 'ci_session=96dc41295663b13d2354f9dd97d3bb3a7b13b8bb'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://kumbharreshimgath.com/api/user_full_profil_update'));
    request.fields.addAll({
      'profile_for': '${param['profile_for']}',
      'first_name': '${param['first_name']}',
      'last_name': '',
      'gender': '${param['gender']}',
      'religion': '${param['religion']}',
      'community': '${param['community']}',
      'family_address': '${param['family_address']}',
      'email': '${param['email']}',
      'mobile': '${param['mobile']}',
      'password': '${param['password']}',
      'dob': '${param['dob']}',
      'birth_place': '${param['birth_place']}',
      'birth_time': '${param['birth_time']}',
      'country': '${param['country']}',
      'state': '${param['state']}',
      'city': '${param['city']}',
      'marital_status': '${param['marital_status']}',
      'caste': ' null',
      'sub_caste': '',
      'gotra': '${param['gotra']}',
      'dosh': '${param['dosh']}',
      'manglik': '${param['manglik']}',
      'language': '${param['language']}',
      'mother_tongue': '${param['mother_tongue']}',
      'physical_status': '${param['physical_status']}',
      'dietary': '${param['dietary']}',
      'height': '${param['height']}',
      'age': '${param['age']}',
      'weight': '${param['weight']}',
      'smoking': '${param['smoking']}',
      'drinking': '${param['drinking']}',
      'qualification': '${param['qualification']}',
      'occupation': '${param['occupation']}',
      'organisation_name': '${param['organisation_name']}',
      'designation': '${param['designation']}',
      'working': '${param['working']}',
      'income': '${param['income']}',
      'horoscope': '${param['horoscope']}',
      'nakchatra': '${param['nakchatra']}',
      'hobbies': '${param['hobbies']}',
      'device_type': '${param['device_type']}',
      'device_token': '${param['device_token']}',
      'pin': '${param['pin']}',
      'family_status': '${param['family_status']}',
      'family_type': '${param['family_type']}',
      'family_city': '${param['family_city']}',
      'family_value': '${param['family_value']}',
      'father_status': '${param['father_status']}',
      'father_name': '${param['father_name']}',
      'mother_name': '${param['mother_name']}',
      'family_state': '${param['family_state']}',
      'family_income': '${param['family_income']}',
      'mother_status': '${param['family_status']}',
      'brother_name': '${param['brother_name']}',
      'description': '${param['description']}',
      'no_brother': '${param['no_brother']}',
      'father_mobile': '${param['father_mobile']}',
      'grand_father_name': '${param['grand_father_name']}',
      'maternal_grand_father_name': 'sds',
      'no_sister': '${param['no_sister']}',
      'user_id': '${curUserId}'
    });
    request.headers.addAll(headers);
    print("checking update parameters here ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      setState(() {});

      setSnackbar(jsonResponse['message'].toString(), context);
      if (jsonResponse['status'] == 1 || jsonResponse['status'] == "1") {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => DashboardView(0)), (
                route) => false);
      }
    }
    else {
      print(response.reasonPhrase);
    }
    //   param['name']= "test";
    //  // param['sub_caste']= "test";
    //   param['brother_name']= "test";
    //   param['device_token']= fcmToken;
    //   param['user_id']= curUserId;
    //   print(param);
    //   var res = await http.post(Uri.parse(baseUrl+"user_full_profil_update"),body: param,headers: {
    //     "Accept-Language" : langCode,
    //   });
    //   print(res.body);
    //   Map response = jsonDecode(res.body);
    //   print(response);
    //   setState(() {
    //     loading = false;
    //   });
    //   setSnackbar(response['message'].toString(), context);
    //   if(response['status'].toString()=="1"){
    //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);
    //
    //   }else{
    //
    //   }
    // }
  }

}
