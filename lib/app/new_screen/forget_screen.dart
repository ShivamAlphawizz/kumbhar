import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/global_widgets/textfield_ui.dart';
import 'package:indianmilan/app/modules/Login/controllers/login.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/modules/login_type/controllers/login_type_controller.dart';
import 'package:indianmilan/app/modules/splash/controllers/splash_controller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/location_details.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/app/utils/widget.dart';
import 'package:sizer/sizer.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  bool toggle = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;

  TextEditingController emailCon = new TextEditingController();
  TextEditingController mobileCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();

    forgotPassword()async{
      var headers = {
        'Cookie': 'ci_session=c780fbe6e21bde25f4b86f19e0e9979ce789e709'
      };
      var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}forgotPassword'));
      request.fields.addAll({
        'email': emailCon.text
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var finalresult  = await response.stream.bytesToString();
        final jsonResponse = json.decode(finalresult);
        setState(() {
          Fluttertoast.showToast(msg: "${jsonResponse['message']}");
        });
        Navigator.pop(context);
      }
      else {
        print(response.reasonPhrase);
      }

    }

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
                height: getHeight(350),
                child: Image.asset(
                  "assets/forget_bg.png",
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
                    Center(
                      child: Container(
                        width: getWidth(140),
                        height: getHeight(149),
                        child: Image.asset(
                          "assets/forget_icon.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    boxHeight(150),
                    Center(
                      child: text("Forgot password",
                          fontFamily: fontMedium,
                          fontSize: 14.sp,
                          textColor: Colors.black
                      ),
                    ),
                    boxHeight(21),
                    Center(
                      child: Container(
                        width: getWidth(625),
                        child: text("Enter the Email associated with your account we will send you a email to reset your password.",
                            fontFamily: fontRegular,
                            fontSize: 10.sp,
                            isCentered: true,
                            textColor: Colors.black
                        ),
                      ),
                    ),

                    boxHeight(97),
                    Center(
                      child:   Container(
                        width: getWidth(625),
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
                    ),
                    boxHeight(90),
                    Center(
                      child: InkWell(
                        onTap: (){
                          // if(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email")!=null){
                          //   setSnackbar(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email").toString(), context);
                          //   return;
                          // }
                          setState(() {
                            loading = true;
                          });
                          if(emailCon.text.isEmpty || !emailCon.text.contains('@')){
                            Fluttertoast.showToast(msg: "Please enter correct email");
                            setState(() {
                              loading = false;
                            });
                          }
                          else{
                            forgotPassword();
                          }

                        //  login();
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
                            child: !loading?text("Send",
                                fontFamily: fontMedium,
                                fontSize: 14.sp,
                                textColor: Colors.white
                            ):loadingWidget(color: Colors.white,),
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
  String otp = "";
  login() async{
    Map param =  {};
    await App.init();
    param['email']= emailCon.text;
    param['password']= passCon.text;
    param['lan']= langCode;
    param['device_type']= "Android";
    param['device_token']= fcmToken;
    print(param);
    var res = await http.post(Uri.parse(baseUrl+"login"),body: param,headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
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

