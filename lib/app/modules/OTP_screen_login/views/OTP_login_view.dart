import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/OTP_screen/controllers/OTP_cotroller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OTP_login_view extends GetView<OTP_Controller> {

  bool toggle = true;
  bool hasError = true;

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
                        margin: EdgeInsets.only(top: 100),
                        //height: 200.toPercentLength.value,
                        child:  Padding(
                            padding: EdgeInsets.all(20),
                            child: Image.asset(
                              CONGRACULATION,
                              fit: BoxFit.fill,
                            )
                        ),
                      ),



                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(00),
                        child: TextFieldShow(
                          color: Colors.black,
                          text: digit_OTP,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontsize: 14,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(00),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(00),
                              child: TextFieldShow(
                                color: Colors.red,
                                text: mobile,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontsize: 14,
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              padding: EdgeInsets.all(00),
                              margin: EdgeInsets.fromLTRB(10, 00, 00, 00),
                              child:  Image.asset(
                                EDIT_MOBILE,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],),
                      ),


                      GestureDetector(
                          onLongPress: () {
                            print("LONG");
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content:
                                    Text("Paste clipboard stuff into the pinbox?"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () async {
                                            var copiedText =
                                            await Clipboard.getData("text/plain");
                                            // if (copiedText.text.isNotEmpty) {
                                            //   // controller1.text = copiedText.text;
                                            // }
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("YES")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("No"))
                                    ],
                                  );
                                });
                          },
                          child:
                          Padding(
                              padding: EdgeInsets.only(left: 60,right: 60),
                              child: PinCodeTextField(

                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 4,
                                obscureText: false,
                                obscuringCharacter: '*',
                                animationType: AnimationType.fade,
                                /*validator: (v) {
      if (v.length < 1) {
        return "I'm from validator";
      } else {
        return null;
      }
    },*/
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 60,
                                  fieldWidth: 50,
                                  selectedFillColor: Colors.white,
                                  activeColor: Colors.black,
                                  selectedColor: Colors.black,
                                  inactiveFillColor: Colors.white,
                                  inactiveColor: Colors.black,
                                  activeFillColor: hasError ? Colors.white : Colors.white,
                                ),
                                cursorColor: Colors.black,
                                animationDuration: Duration(milliseconds: 300),
                                textStyle: TextStyle(fontSize: 20, height: 1.6,color: Colors.black),
                                backgroundColor: Colors.white,
                                enableActiveFill: true,

                                // errorAnimationController: errorController,
                                // controller: controller1,
                                keyboardType: TextInputType.number,
                                boxShadows: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                                onCompleted: (v) {
                                  print("Completed");
                                },
                                // onTap: () {
                                //   print("Pressed");
                                // },
                                onChanged: (value) {
                                  print(value);

                                  controller.currentText.value = value.toString();


                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                              )
                          )

                      ),
                      Container(
                        //padding: const EdgeInsets.fromLTRB(00,00,00,00),
                        height: 50,
                        margin: EdgeInsets.fromLTRB(100,20,100,00),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 00),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            child: TextFieldShow(
                              color: Colors.white,
                              text: VERIFY,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              fontsize: 20,
                            ),
                          ),
                          onTap: () async {

                            Get.toNamed(Routes.Deshboard_view_screen);
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFieldShow(
                          color: Colors.black,
                          text: receive_OTP,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontsize: 14,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFieldShow(
                          color: Colors.red,
                          text: Resend_OTP,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontsize: 14,
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
