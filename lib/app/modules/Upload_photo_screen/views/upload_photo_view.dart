import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/global_widgets/textfield_ui.dart';
import 'package:indianmilan/app/modules/Login/controllers/login.dart';
import 'package:indianmilan/app/modules/OTP_screen/controllers/OTP_cotroller.dart';
import 'package:indianmilan/app/modules/Register/controllers/Register_cotroller.dart';
import 'package:indianmilan/app/modules/Upload_photo_screen/controllers/Upload_photo_cotroller.dart';
import 'package:indianmilan/app/modules/login_type/controllers/login_type_controller.dart';
import 'package:indianmilan/app/modules/splash/controllers/splash_controller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:indianmilan/app/utils/toast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Upload_photo_view extends GetView<Upload_photo_Controller> {
  bool hasError = false;
  bool toggle = true;


  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;





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
      margin: EdgeInsets.only(left: 10),
      height: 60,
      width: 60,
      child: Image.asset(
        BACK_BUTTON,
        fit: BoxFit.cover,
      ),
    );
  }

  Row getHeader() {
    return  Row(
      children: <Widget>[
        GestureDetector(
          onTap:(){
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
    return
      Scaffold(
          backgroundColor: Colors.white,
          body:
          SingleChildScrollView(
            child:  Column(children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child:
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height:  350.toPercentLength.value,
                            child: Image.asset(
                              LOGIN_BACKGRAUND,
                              fit: BoxFit.fill,
                            ),
                          ),

                        ],)

                  ),


                  Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, statusBarHeight, 0.0, 0.0),
                            child: Column(
                              children: <Widget>[getHeader()],
                            ),
                          ),
                          /* Container(
                            margin: EdgeInsets.only(bottom: 10),
                            // padding: EdgeInsets.fromLTRB(20,5,20,5),
                            child: TextFieldShow(
                              color: Colors.white,
                              text: career_details,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              fontsize: 14,
                            ),
                          ),*/
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(00,0,30,0),
                                child: TextFieldShow(
                                  color: Colors.orangeAccent,
                                  text: mandatory,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500,
                                  fontsize: 10,
                                ),
                              ),
                            ],),*/
                        ],),


                      Container(

                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(bottom: 10,right: 20,top: 40),
                        padding: EdgeInsets.all(00),
                        child: TextFieldShow(
                          color: Colors.orangeAccent,
                          text: Add_Photos_Leter,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontsize: 18,
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.only(left: 100,bottom: 50,top: 00,right: 100),
                        child:
                        Container(
                          child:  Image.asset(
                            PROFILE,
                            fit: BoxFit.fill,
                          ),
                        ),

                      )
                      ,


                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(00),
                        child: TextFieldShow(
                          color: Colors.black,
                          text: Add_Your_Photos,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontsize: 18,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(00),
                        child: TextFieldShow(
                          color: Colors.black,
                          text: Complete_Your_Photos,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontsize: 18,
                        ),
                      ),




                      Container(
                        //padding: const EdgeInsets.fromLTRB(00,00,00,00),
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30,20,30,00),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 00),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.blue,
                                width: 1,
                              ),
                            ),
                            child: TextFieldShow(
                              color: Colors.white,
                              text: Create_Profile,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              fontsize: 16,
                            ),
                          ),
                          onTap: () async {
                            Get.toNamed(Routes.PARTNER_PREFERENCE_SCREEN);

                            //Get.offAllNamed(Routes.REGISTER_TWO);
                          },
                        ),
                      ),
                      Container(
                        //padding: const EdgeInsets.fromLTRB(00,00,00,00),
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30,20,30,00),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 00),
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                      CEMERA,
                                      fit: BoxFit.fill,
                                    ),
                                  ),

                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child:
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: TextFieldShow(
                                          color: Colors.black,
                                          text: Create_Profile,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w500,
                                          fontsize: 16,
                                        ),
                                      )
                                  )
                                ],)
                          ),
                          onTap: () async {

                          },
                        ),
                      ),
                    ],)





                ],
              )

            ],),
          )
      );
  }
}
