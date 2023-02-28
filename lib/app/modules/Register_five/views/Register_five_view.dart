import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/global_widgets/textfield_ui.dart';
import 'package:indianmilan/app/modules/Register_five/controllers/Register_five_cotroller.dart';
import 'package:indianmilan/app/modules/Register_six/views/Register_six_view.dart';
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
class Register_five_view extends StatefulWidget {
  var param;


  Register_five_view(this.param);


  @override
  _Register_five_viewState createState() => _Register_five_viewState();
}

class _Register_five_viewState extends State<Register_five_view> {

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

  List<FamilyStatusModel> statusModel = [];
  List<FamilyTypeModel> typeModel = [];
  List<FamilyValueModel> valueModel = [];
  List<OriginModel> originModel = [];
  List<FatherStatusModel> fatherModel = [];
  List<MotherStatusModel> motherModel = [];
  String? statusId,typeId,valueId,originId,fatherId,motherId,incomeId;
  String? stateId,cityId;
  List<StateModel> stateList = [];
  List<CityModel> cityList = [];
  List<IncomeModel> incomeList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    param = widget.param;
    if(model!=null){
    if(model!.familyStatus!=null&&model!.familyStatus!=""){
      statusId = model!.familyStatus.toString();
    }
    if(model!.familyType!=null&&model!.familyType!=""){
      typeId = model!.familyType.toString();
    }
    if(model!.familyValue!=null&&model!.familyValue!=""){
      valueId = model!.familyValue.toString();
    }
    if(model!.origin!=null&&model!.origin!=""){
      originId = model!.origin.toString();
    }
    if(model!.fatherStatus!=null&&model!.fatherStatus!=""){
      fatherId = model!.fatherStatus.toString();
    }
    if(model!.motherStatus!=null&&model!.motherStatus!=""){
      motherId = model!.motherStatus.toString();
    }
    if(model!.noB!=null&&model!.noB!=""){
      countCon.text = model!.noB.toString();
    }
    if(model!.noSister!=null&&model!.noSister!=""){
      sisterCon.text = model!.noSister.toString();
    }
    if(model!.fatherName!=null&&model!.fatherName!=""){
      fatherCon.text = model!.fatherName.toString();
    }
    if(model!.motherName!=null&&model!.motherName!=""){
      motherCon.text = model!.motherName.toString();
    }
    if(model!.fatherMobile!=null&&model!.fatherMobile!=""){
      mobileCon.text = model!.fatherMobile.toString();
    }
    if(model!.grandFatherName!=null&&model!.grandFatherName!=""){
      grandCon.text = model!.grandFatherName.toString();
    }
    if(model!.maternalGrandFatherName!=null&&model!.maternalGrandFatherName!=""){
      mGrandCon.text = model!.maternalGrandFatherName.toString();
    }
    }

  }
  getData()async{
    var res = await http.get(Uri.parse(baseUrl+"get_faimly_status"),headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          statusModel.add(new FamilyStatusModel.fromJson(v));
        });

      }
    }
    res = await http.get(Uri.parse(baseUrl+"getStates"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          stateList.add(new StateModel.fromJson(v));
          if(model!=null){
            if(model!.familyState.toString().toLowerCase()==v['name'].toString().toLowerCase()){
              stateId = v['id'].toString();
              getCity(stateId);
            }
          }
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"get_family_type"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          typeModel.add(new FamilyTypeModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"mm_family_values"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          valueModel.add(new FamilyValueModel.fromJson(v));
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
          if(model!=null){
            if(model!.familyIncome.toString().toLowerCase()==v['income'].toString().toLowerCase()){
              incomeId = v['income'].toString();
            }
          }
        });

      }
    }
    res = await http.get(Uri.parse(baseUrl+"get_origin"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          originModel.add(new OriginModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"get_father_status"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          fatherModel.add(new FatherStatusModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"get_mother"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          motherModel.add(new MotherStatusModel.fromJson(v));
        });
      }
    }


  }
  getCity(stateId)async{
    var res = await http.post(Uri.parse(baseUrl+"getDistrict"),body: {"state_id":stateId},headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      cityList.clear();
    });
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          cityList.add(new CityModel.fromJson(v));
          if(model!=null){
            if(model!.familyCity.toString().toLowerCase()==v['name'].toString().toLowerCase()){
              cityId = v['name'].toString();
            }
          }
        });

      }
    }

  }
  TextEditingController countCon = new TextEditingController();
  TextEditingController sisterCon = new TextEditingController();
  TextEditingController fatherCon = new TextEditingController();
  TextEditingController mobileCon = new TextEditingController();
  TextEditingController motherCon = new TextEditingController();
  TextEditingController grandCon = new TextEditingController();
  TextEditingController mGrandCon = new TextEditingController();
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
                      text("Some details about your family",
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
                            // stateList.length>0?DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //     hint: Row(
                            //       children: const [
                            //         SizedBox(
                            //           width: 4,
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             "Select Family State",
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
                            //     items: stateList
                            //         .map((item) => DropdownMenuItem<String>(
                            //       value: item.id,
                            //       child: Text(
                            //         item.name.toString(),
                            //         style: const TextStyle(
                            //           fontSize: 14,
                            //           fontFamily: fontMedium,
                            //           color: Colors.black,
                            //         ),
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ))
                            //         .toList(),
                            //     value: stateId,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         stateId =value.toString();
                            //       });
                            //       int i =stateList.indexWhere((element) => element.name==stateId);
                            //       getCity(stateId);
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
                      stateList ==  null ? SizedBox() :  DropdownSearch<StateModel>(
                              mode: Mode.DIALOG,
                              showSelectedItem:false,
                              items: stateList,
                              itemAsString: (StateModel u) => u.name.toString(),
                              hint: "select State",
                              onChanged: (value){
                                stateId = value!.id.toString();
                                setState(() {
                                  getCity(stateId);
                                });
                                print("selected country id" + value.id.toString());
                              },
                              showSearchBox: true,
                              filterFn: (instance, filter){
                                if(instance.name!.contains(filter)){
                                  print("filer value here" + filter.toString());
                                  return true;
                                }
                                else{
                                  return false;
                                }
                              },
                              popupItemBuilder: (context,StateModel item,bool isSelected){
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: !isSelected
                                      ? null
                                      : BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(item.name.toString()),
                                  ),
                                );
                              },
                            ),
                            boxHeight(35),
                            // cityList.length>0?DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //     hint: Row(
                            //       children: const [
                            //         SizedBox(
                            //           width: 4,
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             "Select Family City",
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
                            //     items: cityList
                            //         .map((item) => DropdownMenuItem<String>(
                            //       value: item.name,
                            //       child: Text(
                            //         item.name.toString(),
                            //         style: const TextStyle(
                            //           fontSize: 14,
                            //           fontFamily: fontMedium,
                            //           color: Colors.black,
                            //         ),
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ))
                            //         .toList(),
                            //     value: cityId,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         cityId = value.toString();
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
                            DropdownSearch<CityModel>(
                              mode: Mode.DIALOG,
                              showSelectedItem:false,
                              items: cityList,
                              itemAsString: (CityModel u) => u.name.toString(),
                              hint: "select City",
                              onChanged: (value){
                                cityId = value!.id.toString();
                                setState(() {
                                 // getCity(stateId);
                                });
                                print("selected country id" + value.id.toString());
                              },
                              showSearchBox: true,
                              filterFn: (instance, filter){
                                if(instance.name!.contains(filter)){
                                  print("filer value here" + filter.toString());
                                  return true;
                                }
                                else{
                                  return false;
                                }
                              },
                              popupItemBuilder: (context,CityModel item,bool isSelected){
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: !isSelected
                                      ? null
                                      : BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(item.name.toString()),
                                  ),
                                );
                              },
                            ),
                            boxHeight(35),
                            statusModel.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Family Status",
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
                                items: statusModel
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.familyStatus,
                                  child: Text(
                                    item.familyStatus.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: statusId,
                                onChanged: (value) {
                                  setState(() {
                                    statusId = value.toString();
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
                                buttonElevation: 0,
                                itemHeight: 40,
                                itemPadding: EdgeInsets.only(left: 10, right: 10),
                                dropdownMaxHeight: 200,
                                //   dropdownWidth: 350,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                   color: Colors.white,
                                ),
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 5,
                                scrollbarAlwaysShow: true,
                                /*offset: const Offset(20, 0),*/
                              ),
                            ):SizedBox(),
                            boxHeight(35),
                            typeModel.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Family Type",
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
                                items: typeModel
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.familyType,
                                  child: Text(
                                    item.familyType.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: typeId,
                                onChanged: (value) {
                                 setState(() {
                                   typeId = value.toString();
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
                                buttonElevation: 0,
                                itemHeight: 40,
                                itemPadding: EdgeInsets.only(left: 10, right: 10),
                                dropdownMaxHeight: 200,
                                //   dropdownWidth: 350,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                   color: Colors.white,
                                ),
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 5,
                                scrollbarAlwaysShow: true,
                                /*offset: const Offset(20, 0),*/
                              ),
                            ):SizedBox(),
                            boxHeight(35),
                            valueModel.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Family Values",
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
                                items: valueModel
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.familyValues,
                                  child: Text(
                                    item.familyValues.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: valueId,
                                onChanged: (value) {
                                  setState(() {
                                    valueId = value.toString();
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
                                buttonElevation: 0,
                                itemHeight: 40,
                                itemPadding: EdgeInsets.only(left: 10, right: 10),
                                dropdownMaxHeight: 200,
                                //   dropdownWidth: 350,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                   color: Colors.white,
                                ),
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 5,
                                scrollbarAlwaysShow: true,
                                /*offset: const Offset(20, 0),*/
                              ),
                            ):SizedBox(),
                            boxHeight(35),
                            // originModel.length>0?DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //     hint: Row(
                            //       children: const [
                            //         SizedBox(
                            //           width: 4,
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             "Ancestral origin",
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
                            //     items: originModel
                            //         .map((item) => DropdownMenuItem<String>(
                            //       value: item.title,
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
                            //     value: originId,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         originId = value.toString();
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
                            //     buttonElevation: 0,
                            //     itemHeight: 40,
                            //     itemPadding: EdgeInsets.only(left: 10, right: 10),
                            //     dropdownMaxHeight: 200,
                            //     //   dropdownWidth: 350,
                            //     dropdownDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //        color: Colors.white,
                            //     ),
                            //     dropdownElevation: 8,
                            //     scrollbarRadius: const Radius.circular(40),
                            //     scrollbarThickness: 5,
                            //     scrollbarAlwaysShow: true,
                            //     /*offset: const Offset(20, 0),*/
                            //   ),
                            // ):SizedBox(),
                            // boxHeight(35),
                            fatherModel.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Father Status",
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
                                items: fatherModel
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.fathersOccupation,
                                  child: Text(
                                    item.fathersOccupation.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: fatherId,
                                onChanged: (value) {
                                  setState(() {
                                    fatherId = value.toString();
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
                                buttonElevation: 0,
                                itemHeight: 40,
                                itemPadding: EdgeInsets.only(left: 10, right: 10),
                                dropdownMaxHeight: 200,
                                //   dropdownWidth: 350,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                   color: Colors.white,
                                ),
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 5,
                                scrollbarAlwaysShow: true,
                                /*offset: const Offset(20, 0),*/
                              ),
                            ):SizedBox(),
                            // boxHeight(35),
                            // motherModel.length>0?DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //
                            //     hint: Row(
                            //       children: const [
                            //         SizedBox(
                            //           width: 4,
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             "Mother Status",
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
                            //     items: motherModel
                            //         .map((item) => DropdownMenuItem<String>(
                            //       value: item.mothersOccupation,
                            //       child: Text(
                            //         item.mothersOccupation.toString(),
                            //         style: const TextStyle(
                            //           fontSize: 14,
                            //           fontFamily: fontMedium,
                            //           color: Colors.black,
                            //         ),
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ))
                            //         .toList(),
                            //     value: motherId,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         motherId = value.toString();
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
                            //     itemHeight: 40,
                            //     itemPadding: const EdgeInsets.only(left: 14, right: 14),
                            //     dropdownMaxHeight: 200,
                            //     dropdownWidth: 200,
                            //     //dropdownPadding: null,
                            //     //   dropdownWidth: 350,
                            //     dropdownDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       color: Colors.white,
                            //     ),
                            //     dropdownElevation: 8,
                            //     scrollbarRadius: const Radius.circular(40),
                            //     scrollbarThickness: 5,
                            //     scrollbarAlwaysShow: true,
                            //   ),
                            // ):SizedBox(),
                            boxHeight(33),
                            TextFieldDesigned(
                              controller: fatherCon,
                              maxLines: 2,
                              fontSize: 14,

                              minLines: 1,
                              hintText: "Father Name",
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
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: motherCon,
                              maxLines: 2,
                              fontSize: 14,

                              minLines: 1,
                              hintText: "Mother Name",
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
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: mobileCon,
                              maxLines: 2,
                              fontSize: 14,
                              maxLength: 10,
                              minLines: 1,
                              hintText: "Father Mobile Number",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.number,
                              prefixIcon: Icon(
                                Icons.call,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: grandCon,
                              maxLines: 2,
                              fontSize: 14,

                              minLines: 1,
                              hintText: "Grand Father Name",
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
                            // boxHeight(35),
                            // TextFieldDesigned(
                            //   controller: mGrandCon,
                            //   maxLines: 2,
                            //   fontSize: 14,
                            //
                            //   minLines: 1,
                            //   hintText: "Maternal Grand Father Name",
                            //   hintStyle: Color(0xff000000),
                            //   autovalidateMode: AutovalidateMode.onUserInteraction,
                            //   readOnly: false,
                            //   keyboardType: TextInputType.text,
                            //   prefixIcon: Icon(
                            //     Icons.person,
                            //     color: Color(0xffCCD2E3),
                            //     size: 16.0,
                            //   ),
                            // ),
                            boxHeight(35),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFieldDesigned(
                                    controller: countCon,
                                    maxLines: 2,
                                    fontSize: 14,
                                    maxLength: 1,
                                    minLines: 1,
                                    hintText: "No Of Brother",
                                    hintStyle: Color(0xff000000),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    readOnly: false,
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                                boxWidth(10),
                                Expanded(
                                  child: TextFieldDesigned(
                                    controller: sisterCon,
                                    maxLines: 2,
                                    fontSize: 14,
                                    maxLength: 1,
                                    minLines: 1,
                                    hintText: "No Of Sister",
                                    hintStyle: Color(0xff000000),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    readOnly: false,
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                              ],
                            ),
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
                            if(stateId==null){
                              setSnackbar("Please Select Family State", context);
                              return;
                            }
                            if(cityId==null){
                              setSnackbar("Please Select Family City", context);
                              return;
                            }
                            if(statusId==null){
                              setSnackbar("Please Select Family Status", context);
                              return;
                            }
                            if(typeId==null){
                              setSnackbar("Please Select Family Type", context);
                              return;
                            }
                            if(valueId==null){
                              setSnackbar("Please Select Family Value", context);
                              return;
                            }
                            // if(originId==null){
                            //   setSnackbar("Please Select Origin", context);
                            //   return;
                            // }
                            if(fatherId==null){
                              setSnackbar("Please Select Father Status", context);
                              return;
                            }
                            // if(motherId==null){
                            //   setSnackbar("Please Select Mother Status", context);
                            //   return;
                            // }
                            if(fatherCon.text==""){
                              setSnackbar("Please Enter Father Name", context);
                              return;
                            }
                            if(motherCon.text==""){
                              setSnackbar("Please Enter  Mother Name", context);
                              return;
                            }
                            if(mobileCon.text==""&&mobileCon.text.length!=10){
                              setSnackbar("Please Enter Father Mobile Number", context);
                              return;
                            }
                            if(grandCon.text==""){
                              setSnackbar("Please Enter Grand Father Name", context);
                              return;
                            }
                            // if(mGrandCon.text==""){
                            //   setSnackbar("Please Enter Maternal Grand Father Name", context);
                            //   return;
                            // }

                            if(countCon.text==""){
                              setSnackbar("Please Enter Brother Count", context);
                              return;
                            }
                            if(sisterCon.text==""){
                              setSnackbar("Please Enter Sister Count", context);
                              return;
                            }
                            if(incomeId==null){
                              setSnackbar("Please Select Income", context);
                              return;
                            }
                            param['family_status'] = statusId;
                            param['family_type'] = typeId;
                            param['family_state'] = stateId;
                            param['family_city'] = cityId;
                            param['family_status'] = statusId;
                            param['family_type'] = typeId;
                            param['family_value'] = valueId;
                           // param['origin']= originId;
                            param['father_status'] = fatherId;
                            param['mother_status'] = motherId;
                            param['father_name'] = fatherCon.text;
                            param['mother_name'] = motherCon.text;
                            param['father_mobile'] = mobileCon.text;
                            param['grand_father_name'] = grandCon.text;
                            param['family_income'] = incomeId;
                          //  param['maternal_grand_father_name']= mGrandCon.text;
                            param['no_sister'] = sisterCon.text;
                            param['no_brother'] = countCon.text;
                            //  param['language']= langCode;
                            print("sdfsdsfsdsfs ${fatherId} and ${motherId} and ${fatherCon} and ${motherCon.text} and ${mobileCon.text} and ${grandCon.text} and ${incomeId}");
                            print("ok now five ${param}");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_six_view(param)));
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
                    ],),
                )




              ],
            )
        ),
      );
  }



}


