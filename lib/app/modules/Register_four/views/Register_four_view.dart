import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/global_widgets/textfield_ui.dart';
import 'package:indianmilan/app/modules/Login/controllers/login.dart';
import 'package:indianmilan/app/modules/Register/controllers/Register_cotroller.dart';
import 'package:indianmilan/app/modules/Register_five/views/Register_five_view.dart';
import 'package:indianmilan/app/modules/Register_four/controllers/Register_four_cotroller.dart';
import 'package:indianmilan/app/modules/Register_three/controllers/Register_three_cotroller.dart';
import 'package:indianmilan/app/modules/Register_two/controllers/Register_two_cotroller.dart';
import 'package:indianmilan/app/modules/login_type/controllers/login_type_controller.dart';
import 'package:indianmilan/app/modules/splash/controllers/splash_controller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:indianmilan/app/utils/toast.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
class Register_four_view extends StatefulWidget {
  var param;


  Register_four_view(this.param);

  @override
  _Register_four_viewState createState() => _Register_four_viewState();
}

class _Register_four_viewState extends State<Register_four_view> {
  bool toggle = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;
  Map param={};


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
  List<QuaModel> quaList = [];
  List<OccupationModel> occList = [];
  List<WorkingModel> workingList = [];
  List<IncomeModel> incomeList = [];
  List<AgeModel> ageList = [];
  List<DrinkModel> drinkList = [];
  String? quaId,occId,workingId,incomeId,ageId,drinkId,smokingId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    param = widget.param;
    if(model!=null){
   /* if(model!.qualification!=null&&model!.qualification!=""){
      quaId = model!.qualification.toString();
    }*/
    if(model!.occupation!=null&&model!.occupation!=""){
      occId = model!.occupation.toString();
    }
    if(model!.organisationName!=null&&model!.organisationName!=""&&model!.organisationName!="0"){
      companyCon.text = model!.organisationName.toString();
    }

    if(model!.designation!=null&&model!.designation!=""&&model!.designation!="0"){
      designationCon.text = model!.designation.toString();
    }
    if(model!.horoscope!=null&&model!.horoscope!=""&&model!.horoscope!="0"){
      horoCon.text = model!.horoscope.toString();
    }
    if(model!.income!=null&&model!.income!=""){
      incomeId = model!.income.toString();
    }
    if(model!.age!=null&&model!.age!=""){
      ageId = model!.age.toString();
    }
  /*  if(model!.drinking!=null&&model!.drinking!=""){
      drinkId = model!.drinking.toString();
    }*/
    if(model!.smoking!=null&&model!.smoking!=""){
      smokingId = model!.smoking.toString();
    }
    }
  }
  getData()async{
    var res = await http.get(Uri.parse(baseUrl+"getqualification"),headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          quaList.add(new QuaModel.fromJson(v));
        });
        if(model!=null){
          if(model!.qualification.toString().toLowerCase()==v['title'].toString().toLowerCase()){
            quaId = v['id'].toString().toLowerCase();
          }
        }
      }
    }
    res = await http.get(Uri.parse(baseUrl+"getOccupation"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          occList.add(new OccupationModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"get_working_day"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          workingList.add(new WorkingModel.fromJson(v));
          if(model!=null){
            if(model!.working.toString().toLowerCase()==v['title'].toString().toLowerCase()){
              workingId = model!.working.toString();
            }
          }
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"getIncome"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          incomeList.add(new IncomeModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"getDrinkingSmoking"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          drinkList.add(new DrinkModel.fromJson(v));
          if(model!=null){
            if(model!.drinking.toString().toLowerCase()==v['drinking_smoking'].toString().toLowerCase()){
              drinkId =v['drinking_smoking'].toString();
            }
          }
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"age"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          ageList.add(new AgeModel.fromJson(v));
          if(model!=null){
            if(model!.age.toString().toLowerCase()==v['title'].toString().toLowerCase()){
              ageId = v['id'].toString().toLowerCase();
            }
          }
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"nachatra"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          nakList.add(new PhysicalModel1.fromJson(v));
          if(model!=null){
            if(model!.nakchatra.toString().toLowerCase()==v['name'].toString().toLowerCase()){
              nak = model!.nakchatra.toString();
            }
          }
          /*if(model!=null){
            if(model!.nak.toString().toLowerCase()==v['name'].toString().toLowerCase()){
              nak = model!.physicalStatus.toString().toLowerCase();
            }
          }*/
        });

      }
    }
    res = await http.get(Uri.parse(baseUrl+"hobbies"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          hobbiesList.add(new PhysicalModel1.fromJson(v));
          if(model!=null){
            if(model!.hobbies.toString().toLowerCase()==v['name'].toString().toLowerCase()){
              hobbies = model!.hobbies.toString();
            }
          }
        });

      }
    }
  }
  String? hobbies,nak;
  TextEditingController horoCon = new TextEditingController();
  TextEditingController companyCon = new TextEditingController();
  TextEditingController designationCon = new TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  List<PhysicalModel1> hobbiesList = [];
  List<PhysicalModel1> nakList = [];
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
      SafeArea(
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
              title:  getTitle(),
            ),
            backgroundColor: Colors.white,
            body:
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


                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[

                      boxHeight(95),
                      text("Please add your education & career details",
                          fontFamily: fontMedium,
                          fontSize: 12.sp,
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
                            TextFieldDesigned(
                              controller: horoCon,
                              fontSize: 14,
                              minLines: 1,
                              hintText: "Horoscope",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.text,
                              prefixIcon: Icon(
                                Icons.check_box,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                             boxHeight(35),
                            nakList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Nakchatra",
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
                                items: nakList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.name,
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
                                value: nak,
                                onChanged: (value) {
                                  setState(() {
                                    nak = value.toString();
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
                            boxHeight(35),
                            hobbiesList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Hobbies",
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
                                items: hobbiesList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.name,
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
                                value: hobbies,
                                onChanged: (value) {
                                  setState(() {
                                    hobbies = value.toString();
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
                            boxHeight(35),
                            ageList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Your Age",
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
                                items: ageList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.id,
                                  child: Text(
                                    item.title.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: ageId,
                                onChanged: (value) {
                                  setState(() {
                                    ageId = value.toString();
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
                            boxHeight(35),
                            drinkList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Drinking",
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
                                items: drinkList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.drinkingSmoking,
                                  child: Text(
                                    item.drinkingSmoking.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: drinkId,
                                onChanged: (value) {
                                  setState(() {
                                    drinkId = value.toString();
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
                            boxHeight(35),
                            drinkList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Smoking",
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
                                items: drinkList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.drinkingSmoking,
                                  child: Text(
                                    item.drinkingSmoking.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: smokingId,
                                onChanged: (value) {
                                  setState(() {
                                    smokingId = value.toString();
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
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: companyCon,
                              fontSize: 14,
                              minLines: 1,
                              hintText: "Company Name",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.text,
                              prefixIcon: Icon(
                                Icons.home_work_outlined,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: designationCon,
                              fontSize: 14,
                              minLines: 1,
                              hintText: "Designation",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.text,
                              prefixIcon: Icon(
                                Icons.card_travel,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            // quaList.length>0?DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //     hint: Row(
                            //       children: const [
                            //         SizedBox(
                            //           width: 4,
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             "Your Highest Qualification",
                            //             style: TextStyle(
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.w400,
                            //               fontFamily: fontMedium,
                            //               color: Colors.black,
                            //             ),
                            //             overflow: TextOverflow.ellipsis,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     items: quaList
                            //         .map((item) => DropdownMenuItem<String>(
                            //       value: item.id,
                            //       child: Text(
                            //         item.title.toString(),
                            //         style: const TextStyle(
                            //           fontSize: 14,
                            //           fontFamily: fontMedium,
                            //           color: Colors.black,
                            //         ),
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ))
                            //         .toList(),
                            //     value: quaId,
                            //     onChanged: (value) {
                            //      setState(() {
                            //        quaId = value.toString();
                            //      });
                            //     },
                            //     icon: const Icon(
                            //       Icons.keyboard_arrow_down,
                            //       color: Colors.black,
                            //     ),
                            //     iconOnClick: const Icon(
                            //       Icons.keyboard_arrow_up,
                            //       color: Colors.black,
                            //     ),
                            //     iconSize: 14,
                            //     iconEnabledColor: Colors.white,
                            //     iconDisabledColor: Colors.grey,
                            //     buttonHeight: 50,
                            //     buttonWidth: double.infinity,
                            //     buttonPadding:
                            //     const EdgeInsets.only(left: 14, right: 14),
                            //     dropdownPadding:
                            //     EdgeInsets.only(left: 14, right: 14),
                            //     buttonDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       border: Border.all(
                            //         color: Color(0xffc5c4c7),
                            //         //36325A
                            //       ),
                            //       color: Colors.white,
                            //       //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                            //     ),
                            //     //buttonElevation: 2,
                            //     itemHeight: 40,
                            //     itemPadding: EdgeInsets.only(left: 10, right: 10),
                            //     dropdownMaxHeight: 200,
                            //     //   dropdownWidth: 350,
                            //     dropdownDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       //color: Color(0xff211D4A),
                            //     ),
                            //     dropdownElevation: 8,
                            //     scrollbarRadius: const Radius.circular(40),
                            //     scrollbarThickness: 5,
                            //     scrollbarAlwaysShow: true,
                            //     /*offset: const Offset(20, 0),*/
                            //   ),
                            // ):SizedBox(),
                            TextFieldDesigned(
                              controller: qualificationController,
                              fontSize: 14,
                              minLines: 1,
                              hintText: "Highest Qualification",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.text,
                              prefixIcon: Icon(
                                Icons.book_online,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            // occList.length>0?DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //     hint: Row(
                            //       children: const [
                            //         SizedBox(
                            //           width: 4,
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             "Occupation",
                            //             style: TextStyle(
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.w400,
                            //               fontFamily: fontMedium,
                            //               color: Colors.black,
                            //             ),
                            //             overflow: TextOverflow.ellipsis,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     items: occList
                            //         .map((item) => DropdownMenuItem<String>(
                            //       value: item.occupation,
                            //       child: Text(
                            //         item.occupation.toString(),
                            //         style: const TextStyle(
                            //           fontSize: 14,
                            //           fontFamily: fontMedium,
                            //           color: Colors.black,
                            //         ),
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ))
                            //         .toList(),
                            //     value: occId,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         occId = value.toString();
                            //       });
                            //     },
                            //     icon: const Icon(
                            //       Icons.keyboard_arrow_down,
                            //       color: Colors.black,
                            //     ),
                            //     iconOnClick: const Icon(
                            //       Icons.keyboard_arrow_up,
                            //       color: Colors.black,
                            //     ),
                            //     iconSize: 14,
                            //     iconEnabledColor: Colors.white,
                            //     iconDisabledColor: Colors.grey,
                            //     buttonHeight: 50,
                            //     buttonWidth: double.infinity,
                            //     buttonPadding:
                            //     const EdgeInsets.only(left: 14, right: 14),
                            //     dropdownPadding:
                            //     EdgeInsets.only(left: 14, right: 14),
                            //     buttonDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       border: Border.all(
                            //         color: Color(0xffc5c4c7),
                            //         //36325A
                            //       ),
                            //       color: Colors.white,
                            //       //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                            //     ),
                            //     //buttonElevation: 2,
                            //     itemHeight: 40,
                            //     itemPadding: EdgeInsets.only(left: 10, right: 10),
                            //     dropdownMaxHeight: 200,
                            //     //   dropdownWidth: 350,
                            //     dropdownDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       //color: Color(0xff211D4A),
                            //     ),
                            //     dropdownElevation: 8,
                            //     scrollbarRadius: const Radius.circular(40),
                            //     scrollbarThickness: 5,
                            //     scrollbarAlwaysShow: true,
                            //     /*offset: const Offset(20, 0),*/
                            //   ),
                            // ):SizedBox(),
                            TextFieldDesigned(
                              controller: occupationController,
                              fontSize: 14,
                              minLines: 1,
                              hintText: "Occupation",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.text,
                              prefixIcon: Icon(
                                Icons.book_online,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: pinCodeController,
                              fontSize: 14,
                              minLines: 1,
                              maxLength: 6,
                              hintText: "Pincode",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.number,
                              counterText: "",
                              prefixIcon: Icon(
                                Icons.book_online,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            workingList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Your Working as",
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
                                items: workingList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.title,
                                  child: Text(
                                    item.title.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: workingId,
                                onChanged: (value) {
                                  setState(() {
                                    workingId=value.toString();
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
                            boxHeight(35),
                            incomeList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Your Annual Income",
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
                                items: incomeList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.income,
                                  child: Text(
                                    item.income.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: incomeId,
                                onChanged: (value) {
                                  setState(() {
                                    incomeId = value.toString();
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
                            if(horoCon.text==""){
                              setSnackbar("Please Enter Horoscope", context);
                              return;
                            }
                            if(nak==null){
                              setSnackbar("Please Select Nakchatra", context);
                              return;
                            }
                            if(hobbies==null){
                              setSnackbar("Please Select Hobbies", context);
                              return;
                            }
                            if(ageId==null){
                              setSnackbar("Please Select Age", context);
                              return;
                            }
                            if(companyCon.text==""){
                              setSnackbar("Please Enter Company Name", context);
                              return;
                            }
                            if(designationCon.text==""){
                              setSnackbar("Please Enter Designation", context);
                              return;
                            }
                            if(drinkId==null){
                              setSnackbar("Please Select Drinking Status", context);
                              return;
                            }
                            if(smokingId==null){
                              setSnackbar("Please Select Smoking Status", context);
                              return;
                            }
                            if(pinCodeController.text.isEmpty){
                              setSnackbar("Please Enter pincode", context);
                              return;
                            }
                            if(qualificationController.text.isEmpty){
                              setSnackbar("Please Select Qualification", context);
                              return;
                            }
                            // if(occId==null){
                            //   setSnackbar("Please Select Occupation", context);
                            //   return;
                            // }
                            if(occupationController.text.isEmpty){
                              setSnackbar("Please enter occupation", context);
                              return;
                            }
                            if(workingId==null){
                              setSnackbar("Please Select Working day", context);
                              return;
                            }
                            if(incomeId==null){
                              setSnackbar("Please Select Income", context);
                              return;
                            }
                            param['age']= ageId;
                            param['smoking']= smokingId;
                            param['drinking']= drinkId;
                            param['qualification']= qualificationController.text;
                           // param['occupation']= occId;
                            param['occupation'] = occupationController.text;
                            param['organisation_name']= companyCon.text;
                            param['designation']= designationCon.text;
                            param['working']= workingId;
                            param['income']= incomeId;
                            param['horoscope']= horoCon.text;
                            param['nakchatra']= nak;
                            param['hobbies']= hobbies;
                            param['device_type']= "Android";
                            param['device_token']= "";
                            param['pin']= pinCodeController.text;
                            print("ok parameters ${param}");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_five_view(param)));
                          },
                          child: Container(
                            width: getWidth(625),
                            height: getHeight(95),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0,1],
                                  colors: <Color>[Color(0xff4292EB), Color(0xff63BEF5),]),
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
                      boxHeight(70),
                    ],),
                )




              ],
            )
        ),
      );
  }
}

