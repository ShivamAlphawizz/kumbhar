import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/global_widgets/textfield_ui.dart';
import 'package:indianmilan/app/modules/Login/controllers/login.dart';
import 'package:indianmilan/app/modules/Login/views/login_view.dart';
import 'package:indianmilan/app/modules/Register/controllers/Register_cotroller.dart';
import 'package:indianmilan/app/modules/Register_two/views/Register_two_view.dart';
import 'package:indianmilan/app/modules/login_type/controllers/login_type_controller.dart';
import 'package:indianmilan/app/modules/splash/controllers/splash_controller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:indianmilan/app/utils/toast.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/register_model.dart';
import 'package:sizer/sizer.dart';
class Register_view extends StatefulWidget {
  const Register_view({Key? key}) : super(key: key);

  @override
  _Register_viewState createState() => _Register_viewState();
}

class _Register_viewState extends State<Register_view> {
  bool toggle = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;

  TextEditingController nameCon = new TextEditingController();
  TextEditingController lastCon = new TextEditingController();
  TextEditingController addressCon = new TextEditingController();
  String? relId;
  String? comId;
  String? genId;
  String? typeCon;
  String? genCon;
  List<String> gender = ["Male","Female","Other"];
  List<String> profile = ["Self","Other"];
  List<ReligionModel> relList = [];
  List<GenderModel> genList = [];
  List<String> langList = ["English","Hindi"];
  List<CommunityModel> comList = [];
  Widget getTitle() {
    return text(model!=null?"Update Profile":SIGNUP,
        fontFamily: fontMedium,
        fontSize: 20.sp,
        textColor: Color(0xffFECC2F)
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
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap:(){
            Get.back();
          },
          child: getBackButton(),
        ),
        getTitle(),
        model==null?Container(
            width: 150,
            padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10),
            child:  DropdownButton2(
              isExpanded: true,
              dropdownWidth: 100,
              underline: SizedBox(),
              items: langList
                  .map((item) => DropdownMenuItem<String>(
                value: item=="English"?"en":"hi",
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: fontMedium,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
                  .toList(),
              value: langCode,
              onChanged: (value) {
                setState(() {
                  langCode = value.toString();
                });
                getData(true);
              },
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              iconOnClick: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.black,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.grey,
              buttonHeight: 50,
              buttonWidth: double.infinity,
              buttonPadding:
              const EdgeInsets.only(left: 14, right: 14),
              dropdownPadding:
              EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xffc5c4c7),
                  //36325A
                ),
                color: Colors.white,
                //image: DecorationImage(image: AssetImage(BORDER_PNG)),
              ),
              //buttonElevation: 2,
              itemHeight: 40,
              itemPadding: EdgeInsets.only(left: 10, right: 10),
              dropdownMaxHeight: 200,
              //   dropdownWidth: 350,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                //color: Color(0xff211D4A),
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 5,
              scrollbarAlwaysShow: true,
              /*offset: const Offset(20, 0),*/
            )
        ):SizedBox(),
      ],
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(model!=null){
      /*if(model!.religion!=null&&model!.religion!=""){
        relId = model!.religion;
      }
      if(model!.community!=null&&model!.community!=""){
        comId = model!.community;
      }*/
      if(model!.name!=null&&model!.name!=""){
        nameCon.text = model!.name.toString();
      }
      if(model!.familyAddress!=null&&model!.familyAddress!=""){
        addressCon.text = model!.familyAddress.toString();
      }
      if(model!.profileFor!=null&&model!.profileFor!=""){
        typeCon = model!.profileFor;
      }
    }

    getData(false);
  }
  getData(status)async{
    setState(() {
      relList.clear();
      comList.clear();
      genList.clear();
      if(status){
        genId = null;
        typeCon = null;
        comId  = null;
        relId = null;
      }

    });
    var res = await http.get(Uri.parse(baseUrl+"get_religion"),headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          relList.add(new ReligionModel.fromJson(v));
        });
        if(model!=null){
          if(model!.religion.toString().toLowerCase()==v['region'].toString().toLowerCase()){
            relId = model!.religion.toString();
          }
        }
      }
    }
    res = await http.get(Uri.parse(baseUrl+"getGender"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          genList.add(new GenderModel.fromJson(v));
        });
      }
      if(model!=null)
        setState(() {
          if(model!.gender!=null&&model!.gender!=""){
            int i = genList.indexWhere((element) => element.gender==model!.gender.toString());
            if(i!=-1){
              genId = genList[i].genderId;
            }
          }
        });

    }
    res = await http.get(Uri.parse(baseUrl+"get_community"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          comList.add(new CommunityModel.fromJson(v));
        });
        if(model!=null){
          if(model!.community.toString()==v['name'].toString()){
            comId = v['id'].toString();
          }
        }
      }
    }
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
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap:(){
                Navigator.pop(context);
              },
              child: getBackButton(),
            ),
            centerTitle: true,
            title:  text(model!=null?"Update Profile":SIGNUP,
                fontFamily: fontMedium,
                fontSize: 20.sp,
                textColor: Color(0xffFECC2F)
            ),
            actions: [
              /* model==null?Container(
                width: 110,
                padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5),
                child:  DropdownButton2(
                  isExpanded: true,
                  dropdownWidth: 100,
                  underline: SizedBox(),
                  items: langList
                      .map((item) => DropdownMenuItem<String>(
                    value: item=="English"?"en":"hi",
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: fontMedium,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: langCode,
                  onChanged: (value) {
                    setState(() {
                      langCode = value.toString();
                    });
                    getData(true);
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                  iconOnClick: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.black,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: 50,
                  buttonWidth: double.infinity,
                  buttonPadding:
                  const EdgeInsets.only(left: 14, right: 14),
                  dropdownPadding:
                  EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xffc5c4c7),
                      //36325A
                    ),
                    color: Colors.white,
                    //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                  ),
                  //buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: EdgeInsets.only(left: 10, right: 10),
                  dropdownMaxHeight: 200,
                  //   dropdownWidth: 350,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    //color: Color(0xff211D4A),
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 5,
                  scrollbarAlwaysShow: true,
                  *//*offset: const Offset(20, 0),*//*
                )
            ):SizedBox(),*/
            ],
          ),
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
                  children: <Widget>[
                    boxHeight(95),
                    text("Let's Find Perfect Match For You",
                        fontFamily: fontMedium,
                        fontSize: 15.sp,
                        textColor:Colors.white
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
                              textColor:Color(0xffFECC2F)
                          ),
                        ],),
                    ),
                    boxHeight(15),
                    Container(
                      width: getWidth(625),
                      padding: EdgeInsets.symmetric(horizontal: getWidth(24),vertical: getHeight(40)),
                      decoration: boxDecoration(
                        radius: 20,
                        showShadow: true,
                        bgColor: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: const [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Profile For",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: fontMedium,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: profile
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: fontMedium,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: typeCon,
                              onChanged: (value) {
                                setState(() {
                                  typeCon = value.toString();
                                });

                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              iconOnClick: const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: double.infinity,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              dropdownPadding:
                              EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xffc5c4c7),
                                  //36325A
                                ),
                                color: Colors.white,
                                //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                              ),
                              //buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding: EdgeInsets.only(left: 10, right: 10),
                              dropdownMaxHeight: 200,
                              //   dropdownWidth: 350,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                //color: Color(0xff211D4A),
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 5,
                              scrollbarAlwaysShow: true,
                              /*offset: const Offset(20, 0),*/
                            ),
                          ),
                          boxHeight(33),
                          TextFieldDesigned(
                            controller: nameCon,
                            maxLines: 2,
                            fontSize: 14,
                            maxLength: 25,
                            minLines: 1,
                            hintText: "Full Name",
                            hintStyle: Color(0xff000000),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color(0xffCCD2E3),
                              size: 16.0,
                            ),
                          ),
                          boxHeight(33),
                          TextFieldDesigned(
                            controller: addressCon,
                            maxLines: 2,
                            fontSize: 14,
                            maxLength: 25,
                            minLines: 1,
                            hintText: "Address",
                            hintStyle: Color(0xff000000),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Color(0xffCCD2E3),
                              size: 16.0,
                            ),
                          ),
                          boxHeight(33),
                          /*  Container(
                              margin: EdgeInsets.fromLTRB(00, 10, 00, 00),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: MediaQuery.of(context).size.height * 0.03),
                                child: TextFieldDesigned(
                                  controller: lastCon,
                                  maxLines: 2,
                                  fontSize: 14,
                                  maxLength: 25,
                                  minLines: 1,
                                  hintText: "Last Name",
                                  hintStyle: Color(0xff000000),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  readOnly: false,
                                  keyboardType: TextInputType.text,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color(0xffCCD2E3),
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ),*/
                          genList.length>0?DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: const [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Gender",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: fontMedium,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: genList
                                  .map((item) => DropdownMenuItem<String>(
                                value: item.genderId,
                                child: Text(
                                  item.gender.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: fontMedium,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: genId,
                              onChanged: (value) {
                                setState(() {
                                  genId = value.toString();
                                });
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              iconOnClick: const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: double.infinity,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              dropdownPadding:
                              EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xffc5c4c7),
                                  //36325A
                                ),
                                color: Colors.white,
                                //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                              ),
                              //buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding: EdgeInsets.only(left: 10, right: 10),
                              dropdownMaxHeight: 200,
                              //   dropdownWidth: 350,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                //color: Color(0xff211D4A),
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 5,
                              scrollbarAlwaysShow: true,
                              /*offset: const Offset(20, 0),*/
                            ),
                          ):SizedBox(),
                          boxHeight(33),
                          relList.length>0?DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: const [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Religion",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: fontMedium,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: relList
                                  .map((item) => DropdownMenuItem<String>(
                                value: item.region.toString(),
                                child: Text(
                                  item.region.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: fontMedium,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: relId,
                              onChanged: (value) {
                                setState(() {
                                  relId = value.toString();
                                });
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              iconOnClick: const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: double.infinity,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              dropdownPadding:
                              EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xffc5c4c7),
                                  //36325A
                                ),
                                color: Colors.white,
                                //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                              ),
                              //buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding: EdgeInsets.only(left: 10, right: 10),
                              dropdownMaxHeight: 200,
                              //   dropdownWidth: 350,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                //color: Color(0xff211D4A),
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 5,
                              scrollbarAlwaysShow: true,
                              /*offset: const Offset(20, 0),*/
                            ),
                          ):SizedBox(),
                          boxHeight(33),
                          comList.length>0?DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: const [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Community",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: fontMedium,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: comList
                                  .map((item) => DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(
                                  item.name.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: fontMedium,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: comId,
                              onChanged: (value) {
                                setState(() {
                                  comId = value.toString();
                                });
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              iconOnClick: const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.black,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: double.infinity,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              dropdownPadding:
                              EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xffc5c4c7),
                                  //36325A
                                ),
                                color: Colors.white,
                                //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                              ),
                              //buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding: EdgeInsets.only(left: 10, right: 10),
                              dropdownMaxHeight: 200,
                              //   dropdownWidth: 350,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                //color: Color(0xff211D4A),
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 5,
                              scrollbarAlwaysShow: true,
                              /*offset: const Offset(20, 0),*/
                            ),
                          ):SizedBox(),
                        ],),
                    ),
                    boxHeight(70),
                    Center(
                      child: InkWell(
                        onTap: (){
                          if(typeCon==null){
                            setSnackbar("Please Select Profile Type", context);
                            return;
                          }
                          if(nameCon.text==""){
                            setSnackbar("Please Enter Full Name", context);
                            return;
                          }
                          if(addressCon.text==""){
                            setSnackbar("Please Enter Address", context);
                            return;
                          }
                          /*  if(lastCon.text==""){
                              setSnackbar("Please Enter Last Name", context);
                              return;
                            }*/
                          if(genId==null){
                            setSnackbar("Please Select Gender", context);
                            return;
                          }
                          if(relId==null){
                            setSnackbar("Please Select Religion", context);
                            return;
                          }
                          if(comId==null){
                            setSnackbar("Please Select Community", context);
                            return;
                          }
                          Map param ={
                            "profile_for" : typeCon,
                            "first_name" : nameCon.text,
                            "last_name" : lastCon.text,
                            "gender" : genId,
                            "religion" : relId,
                            "community" : comId,
                            "family_address" : addressCon.text,
                          };
                          print("parameters are here ${param}");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_two_view(param)));
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
                            child: text("Continue",
                                fontFamily: fontMedium,
                                fontSize: 14.sp,
                                textColor: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                    boxHeight(78),
                    model==null?InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>login_view()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text("Already have an account?",
                              fontFamily: fontMedium,
                              fontSize: 10.sp,
                              textColor: Colors.black
                          ),
                          text(" Login",
                              fontFamily: fontMedium,
                              fontSize: 10.sp,
                              textColor: Colors.red
                          ),
                        ],
                      ),
                    ):SizedBox(),
                  ],),
              )




            ],
          )
      ),
    );
  }
}
