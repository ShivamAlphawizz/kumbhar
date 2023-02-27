import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/Home/controllers/HomeNavigation.dart';
import 'package:indianmilan/app/modules/Login/views/login_view.dart';
import 'package:indianmilan/app/modules/My_profile/controllers/profile_controller.dart';
import 'package:indianmilan/app/modules/Register/views/Register_view.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/utils/ApiBaseHelper.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import '../../../routes/app_pages.dart';
import 'package:path/path.dart' as path;
class profile_view extends StatefulWidget {
  const profile_view({Key? key}) : super(key: key);

  @override
  _profile_viewState createState() => _profile_viewState();
}

class _profile_viewState extends State<profile_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (

      appBar:AppBar(
        title: Text("My Profile"),
        centerTitle: true,

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.blue, Colors.pink]),
          ),
        ),

        actions: [
          GestureDetector(
              onTap:() {
                Get.toNamed(Routes.Notofication_screen);
              },

              child:  Container(
                margin: EdgeInsets.only(right: 12),
                child: Icon(Icons.notifications_none_outlined,color: Colors.white,),
              )

          )
        ],

        leading:  GestureDetector(
          onTap:(){
            Navigator.pop(context);
          },
          child:  Container(
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

      body: ListView(
        children: [

          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [

                Container(
                  height: MediaQuery.of(context).size.height/5,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      InkWell(
                        onTap: (){
                          requestPermission(context);
                        },
                        child: Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: _image!=null?Image.file(_image!):commonImage(model!.userAvtar, 100.0, 100.0, "", context, PROFILE),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: -10,
                              child: Container(
                                decoration: boxDecoration(radius: 100,showShadow: true),
                                padding: EdgeInsets.all(5),
                                child: Icon(Icons.edit_outlined,color: Colors.yellow,size: 20,),
                              ),
                            )
                          ],
                        ),
                      ),
                      // CircleAvatar(
                      //   foregroundColor: Colors.white,
                      //
                      //    radius: 35,
                      //   backgroundImage: AssetImage('images/profileimage.png'),
                      // ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(getString1(model!.name.toString()), style:TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16)),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 22,top: 15,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Basic Info",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_view()));
                        },
                        child: Container(
                            child:Icon(Icons.edit)
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: boxDecoration(
                    color: Colors.grey,
                    radius: 10,
                  ),
                  child: Container(

                    margin: EdgeInsets.all(10),
                    width: 370,

                    child: Column(
                      children: [

                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Posted by :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.profileFor.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Age :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text("${model!.age.toString()} years ",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Marital Status :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.maritalStatus.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Height :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.height.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Any Disablity :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.dosh.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


                            ],
                          ),
                        )

                      ],
                    ),

                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 22,top: 15,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("About Myself",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),),
                      ),

                      Container(

                      )
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: boxDecoration(
                    color: Colors.grey,
                    radius: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 370,

                    child: Column(
                      children: [
                        Container(
                          child: Text(model!.aboutMe.toString(),textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15),
                          ),

                        )
                      ],
                    ),

                  ),
                ),


                Container(
                  padding: EdgeInsets.only(left: 22,top: 15,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Religious background",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),),
                      ),

                      Container(

                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: boxDecoration(
                    color: Colors.grey,
                    radius: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 370,

                    child: Column(
                      children: [

                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Religion :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.caste.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Language preferred :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.language.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Community :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.community.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


                            ],
                          ),
                        ),

                       /* Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Sub community :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.csutId.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("No Caste Bar :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text("Yes",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Gothra :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.gotra.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


                            ],
                          ),
                        )

                      ],
                    ),

                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 22,top: 15,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Family background",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),),
                      ),
                      Container(

                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: boxDecoration(
                    color: Colors.grey,
                    radius: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 370,

                    child: Column(
                      children: [

                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Family status :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.familyStatus.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Family type :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.familyType.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("FAmily values :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.familyValue.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Ancestral origin :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.origin.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Father's status :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.fatherStatus.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Mother's status :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.motherStatus.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("No. of brothers and sisters:",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.noB.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


                            ],
                          ),
                        ),

                        /* Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("No. of sisters :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text("0",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


                            ],
                          ),
                        )*/

                      ],
                    ),

                  ),
                ),


                Container(
                  padding: EdgeInsets.only(left: 22,top: 15,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Location, Education & Career",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),),
                      ),

                      Container(

                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: boxDecoration(
                    color: Colors.grey,
                    radius: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 370,

                    child: Column(
                      children: [

                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("State living :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.state.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("City leaving :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.city.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Qualification :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.qualification.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Occupation :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.occupation.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Working as :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.organisationName.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Annual income :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.income.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


                            ],
                          ),
                        ),


                      ],
                    ),

                  ),
                ),


                Container(
                  padding: EdgeInsets.only(left: 22,top: 15,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Life style",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),),
                      ),

                      Container(

                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: boxDecoration(
                    color: Colors.grey,
                    radius: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 370,

                    child: Column(
                      children: [

                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Diet :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.dietary.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Smoking :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.smoking.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


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
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Drinking :",style: TextStyle(fontSize: 16,color: Colors.grey),),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10,left: 20),
                                  child: Text(model!.drinking.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                                ),
                              ),


                            ],
                          ),
                        ),

                      ],
                    ),

                  ),
                ),









              ],

            ),
          ),

        ],

      ),

    );
  }
  File? _image;
  Future getImage(ImgSource source, BuildContext context) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _image = File(image.path);
      getCropImage(context);
    });
  }

  void getCropImage(BuildContext context) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      _image = croppedFile;
    });
    submitSubscription();
  }
  bool selected = false, enabled = false, edit1 = false;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  Future<void> submitSubscription() async {
    await App.init();

    ///MultiPart request
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        if (_image != null) {
          var request = http.MultipartRequest(
            'POST',
            Uri.parse(baseUrl + "setProfileImage"),
          );
          Map<String, String> headers = {
            "token": App.localStorage.getString("token").toString(),
            "Content-type": "multipart/form-data"
          };
          request.files.add(
            http.MultipartFile(
              'user_avtar',
              _image!.readAsBytes().asStream(),
              _image!.lengthSync(),
              filename: path.basename(_image!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
          request.headers.addAll(headers);
          request.fields.addAll({

            "user_id": curUserId.toString(),

          });
          print("request: " + request.toString());
          var res = await request.send();
          print("This is response:" + res.toString());
          setState(() {
            selected = false;
          });
          if (res.statusCode == 200) {
            final respStr = await res.stream.bytesToString();
            print(respStr.toString());
            Map data = jsonDecode(respStr.toString());

            if (data['status'].toString()=="1") {
              setState(() {
                setSnackbar(data['message'].toString(), context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);
              });
            } else {
              setSnackbar(data['message'].toString(), context);
            }
          }
        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          selected = true;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        selected = true;
      });
    }
  }
  void requestPermission(BuildContext context) async{
    if (await Permission.camera.isPermanentlyDenied||await Permission.storage.isPermanentlyDenied) {

      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
    else{
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();
// You can request multiple permissions at once.

      if(statuses[Permission.camera]==PermissionStatus.granted&&statuses[Permission.storage]==PermissionStatus.granted){
        getImage(ImgSource.Gallery, context);

      }else{
        if (await Permission.camera.isDenied||await Permission.storage.isDenied) {

          // The user opted to never again see the permission request dialog for this
          // app. The only way to change the permission's status now is to let the
          // user manually enable it in the system settings.
          openAppSettings();
        }else{
          setSnackbar("Oops you just denied the permission", context);
        }

      }
    }

  }
}


