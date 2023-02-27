import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/Login/views/login_view.dart';
import 'package:indianmilan/app/modules/Register/views/Register_view.dart';
import 'package:indianmilan/app/modules/login_type/controllers/login_type_controller.dart';
import 'package:indianmilan/app/modules/splash/controllers/splash_controller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:sizer/sizer.dart';


class login_type_View extends GetView<login_typeController> {

  @override
  Widget build(BuildContext context) {
    //LocalNotificationService.initialize(context);
    return
      SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(LOGIN_TYPE_BACKGRAUND),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                  child:
                  Column(
                    children: <Widget>[
                      Container(
                        width: getWidth(720),
                        height: getHeight(555),
                        child: Image.asset(
                          LOGIN_TYPE_COUPLE,
                          fit: BoxFit.fill,
                        ),
                      ),
                      boxHeight(63),
                      text("Welcome to",
                      fontFamily: fontMedium,
                        fontSize: 14.sp,
                        textColor: Colors.black
                      ),
                      boxHeight(12),
                      Container(
                        width: getWidth(442),
                        height: getHeight(200),
                        child: Image.asset(
                          SPLASH_IMAGE,
                          fit: BoxFit.fill,
                        ),
                      ),
                      boxHeight(60),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>login_view()));
                        },
                        child: Container(
                          width: getWidth(625),
                          height: getHeight(95),
                          decoration: boxDecoration(
                            bgColor: Colors.white.withOpacity(0.4),
                            radius: 10.0,
                          ),
                          child: Center(
                            child: text("Login",
                                fontFamily: fontMedium,
                                fontSize: 14.sp,
                                textColor: Colors.black
                            ),
                          ),
                        ),
                      ),
                      boxHeight(54),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_view()));
                        },
                        child: Container(
                          width: getWidth(625),
                          height: getHeight(95),
                          decoration: boxDecoration(
                            bgColor: Colors.transparent,
                            color: Colors.white,
                            radius: 10.0,
                          ),
                          child: Center(
                            child: text("Sign Up",
                                fontFamily: fontMedium,
                                fontSize: 14.sp,
                                textColor: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],)
              ),
            )
          ),
        ),
      );
  }
}
