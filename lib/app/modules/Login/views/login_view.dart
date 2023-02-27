import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/global_widgets/textfield_ui.dart';
import 'package:indianmilan/app/modules/Login/controllers/login.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/modules/login_type/controllers/login_type_controller.dart';
import 'package:indianmilan/app/modules/splash/controllers/splash_controller.dart';
import 'package:indianmilan/app/new_screen/forget_screen.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/location_details.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/app/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../../Register/views/Register_view.dart';
class login_view extends StatefulWidget {
  const login_view({Key? key}) : super(key: key);

  @override
  _login_viewState createState() => _login_viewState();
}

class _login_viewState extends State<login_view> {
  bool toggle = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;

  TextEditingController emailCon = new TextEditingController();
  TextEditingController mobileCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();

  Widget getTitle() {
    return Container(
      margin: EdgeInsets.only(left: 00),
      child: TextFieldShow(
        color: Colors.orangeAccent,
        text: LOGIN,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w300,
        fontsize: 25,
      ),
    );
  }

  Container getBackButton() {
    return
      Container(
        margin: EdgeInsets.only(left: getWidth(40)),
        height: getHeight(50),
        width: getHeight(50),
        child: Image.asset(
          BACK_BUTTON,
          fit: BoxFit.fill,
        ),
      );;
  }

  Row getHeader() {
    return  Row(
      children: <Widget>[

        const Spacer(
          flex: 1,
        ),
        getTitle(),

        const Spacer(flex: 2)
      ],
    );
  }
  bool show = true;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // bool isScreenWide = MediaQuery.of(context).size.width >= kMinWidthOfLargeScreen;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    beginWidth = Dimension.max(20.toPercentLength, 700.toPXLength);
    beginHeight = (90.toVHLength - 10.toPXLength);
    endWidth = Dimension.clamp(200.toPXLength, 40.toVWLength, 200.toPXLength);
    endHeight = 50.toVHLength +
        10.toPercentLength -
        Dimension.min(4.toPercentLength, 40.toPXLength);
    //LocalNotificationService.initialize(context);
    return  SafeArea(
      child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                Container(
                  width: getWidth(720),
                  height: getHeight(552),
                  child: Image.asset(
                    LOGIN_BACKGRAUND,
                    fit: BoxFit.fill,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      boxHeight(40),
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: getBackButton(),
                      ),
                      boxHeight(57),
                      Center(
                        child: text("Login",
                            fontFamily: fontMedium,
                            fontSize: 24.sp,
                            textColor: Color(0xffFECC2F)
                        ),
                      ),
                      boxHeight(97),
                      Center(
                        child: Container(
                          width: getWidth(625),
                          padding: EdgeInsets.symmetric(horizontal: getWidth(24),vertical: getHeight(40)),
                          decoration: boxDecoration(
                            radius: 20,
                            showShadow: true,
                            bgColor: Colors.white,
                          ),
                          child:  Column(
                            children: <Widget>[
                              Container(
                                child: TextFieldDesigned(
                                  controller: emailCon,
                                  maxLines: 2,
                                  fontSize: 14,
                                  maxLength: 30,
                                  minLines: 1,
                                  hintText: "Your Email",
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  readOnly: false,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                              boxHeight(60),
                              TextFormField(
                                maxLength: 20,
                                style: TextStyle(color: Colors.black),
                                controller: passCon,
                                obscureText: show,
                                decoration: InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffC4C4C4)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffC4C4C4)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffC4C4C4)),
                                    //36325A
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffC4C4C4)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  counterText: '',
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                    size: 16.0,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffffffff),
                                  hintText: 'Password'.tr,
                                  hintStyle: TextStyle(fontSize: 14.0, color:Color(0xff000000)),
                                  suffixIcon: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      setState(() {
                                        show = !show;
                                      });
                                    },
                                    child: Icon(
                                      show
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                  ),

                                ),
                              ),
                              boxHeight(32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                 /* GestureDetector(
                                    onTap: (){
                                      Get.toNamed(Routes.OTP_SCREEN);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      child: TextFieldShow(
                                        color: Colors.red,
                                        text: LOGIN_WITH_OTP,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w500,
                                        fontsize: 14,
                                      ),
                                    ),
                                  ),*/
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetScreen()));
                                    },
                                    child: text("Forgot Password",
                                        fontFamily: fontMedium,
                                        fontSize: 10.sp,
                                        textColor: Color(0xffFF7B7B)
                                    ),
                                  ),
                                ],),
                            ],),
                        ),
                      ),
                      boxHeight(90),
                      Center(
                        child: InkWell(
                          onTap: (){
                            if(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email")!=null){
                              setSnackbar(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email").toString(), context);
                              return;
                            }
                           /* if(emailCon.text==""){
                              setSnackbar("Please Enter Email ID", context);
                              return;
                            }*/
                            if(passCon.text==""){
                              setSnackbar("Please Enter Valid Password", context);
                              return;
                            }
                            setState(() {
                              loading = true;
                            });
                            login();
                          },
                          child: Container(
                            width: getWidth(625),
                            height: getHeight(95),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0,1],
                                  colors: <Color>[Color(0xffF72D2D), Color(0xffF5F049),]),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: !loading?text("Login",
                                  fontFamily: fontMedium,
                                  fontSize: 14.sp,
                                  textColor: Colors.white
                              ):loadingWidget(color: Colors.white,),
                            ),
                          ),
                        ),
                      ),
                      boxHeight(200),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_view()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text("Don’t have an account?",
                                fontFamily: fontMedium,
                                fontSize: 10.sp,
                                textColor: Colors.black
                            ),
                            text(" Register Now",
                                fontFamily: fontMedium,
                                fontSize: 10.sp,
                                textColor: Colors.red
                            ),
                          ],
                        ),
                      ),

                    ],),
                )




              ],
            )
        ),
    );
  }
  bool loading = false;
  String otp = "";
  login() async{
    Map param =  {};

    await App.init();
    param['email']= emailCon.text;
    param['password']= passCon.text;
    param['lan']= langCode;
    param['device_type']= "Android";
    param['device_token']= fcmToken;
    print("paramters here" + param.toString());
    print("api here  ${baseUrl}login");
    var res = await http.post(Uri.parse(baseUrl+"login"),body: param,headers: {
      "Accept-Language" : langCode,
    });
    print(res.body.toString());
    print(res.headers.toString());
    Map response = jsonDecode(res.body);
    print(response.toString());
    setState(() {
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if(response['status'].toString()=="1"){
      App.localStorage
          .setString("userId", response['data']['user_id'].toString());
      curUserId = response['data']['user_id'].toString();
      GetLocation location = new GetLocation((result){
        address = result.first.addressLine;
        latitude = result.first.coordinates.latitude;
        longitude = result.first.coordinates.longitude;
      });
      location.getLoc();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);
    }else{

    }

  }
}

