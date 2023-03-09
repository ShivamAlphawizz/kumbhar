import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/Register_four/views/Register_four_view.dart';
import 'package:indianmilan/app/modules/Register_three/controllers/Register_three_cotroller.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
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

class UpdatePartner extends StatefulWidget {
  @override
  _UpdatePartnerState createState() => _UpdatePartnerState();
}

class _UpdatePartnerState extends State<UpdatePartner> {
  bool toggle = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;

  Map param = {};


  TextEditingController qualificationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();


  Widget getTitle() {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      height: 50,
      width: 150,
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
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(getWidth(20)),
            height: getHeight(50),
            width: getHeight(50),
            child: Image.asset(
              BACK_BUTTON,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const Spacer(
          flex: 1,
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
    getData();
    /* param = widget.param;
    if(model!=null){
      */
    /* if(model!.state!=null&&model!.state!=""){
        stateId = model!.state.toString();
      }*/ /*
      if(model!.city!=null&&model!.city!=""){
        cityId = model!.city.toString();
      }
      if(model!.maritalStatus!=null&&model!.maritalStatus!=""){
        marry = model!.maritalStatus.toString();
      }
      */ /* if(model!.caste!=null&&model!.caste!=""){
        castId = model!.caste.toString();
      }*/ /*
      if(model!.subId!=null&&model!.subId!=""){
        subId = model!.subId.toString();
      }
      if(model!.gotra!=null&&model!.gotra!=""){
        gotraId = model!.gotra.toString();
      }
      if(model!.manglik!=null&&model!.manglik!=""){
        manglicId = model!.manglik.toString();
      }
      */ /*  if(model!.height!=null&&model!.height!=""){
        heightId = model!.height.toString();
      }*/ /*
      if(model!.dosh!=null&&model!.dosh!=""){
        doshId = model!.dosh.toString();
      }
      if(model!.language!=null&&model!.language!=""){
        langId = model!.language.toString();
      }
      if(model!.dietary!=null&&model!.dietary!=""){
        dietId = model!.dietary.toString();
      }
      if(model!.physicalStatus!=null&&model!.physicalStatus!=""){
        physical = model!.physicalStatus.toString();
      }
    }*/
  }

  List<StateModel> stateList = [];
  List<CityModel> cityList = [];
  List<String> statusList = ["Married", "Unmarried"];
  List<CastModel> castList = [];
  List<SubCastModel> subList = [];
  List<GotraModel> gotraList = [];
  List<ManglicModel> manglicList = [];
  List<HeightModel> heightList = [];
  List<DoshModel> doshList = [];
  List<langModel> langList = [];
  List<dietModel> dietList = [];
  List<OccupationModel> occList = [];
  List<WorkingModel> workingList = [];
  List<IncomeModel> incomeList = [];
  List<AgeModel> ageList = [];
  List<QuaModel> quaList = [];
  List<DrinkModel> drinkList = [];
  List<ReligionModel> relList = [];
  String? relId;
  String? quaId, occId, workingId, incomeId, ageId, drinkId;
  String? stateId,
      cityId,
      marry,
      castId,
      subId,
      gotraId,
      manglicId,
      heightId,
      doshId,
      langId,
      dietId,
      physical;
  getData() async {
    var res = await http.get(Uri.parse(baseUrl + "getStates"), headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          stateList.add(new StateModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "gontra"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          gotraList.add(new GotraModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "getManglik"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          manglicList.add(new ManglicModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "getHeight"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          heightList.add(new HeightModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "getLanguage"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          langList.add(new langModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "mm_diet"));
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          dietList.add(new dietModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "getqualification"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          quaList.add(new QuaModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "getOccupation"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          occList.add(new OccupationModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "getIncome"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          incomeList.add(new IncomeModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "getDrinkingSmoking"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          drinkList.add(new DrinkModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "age"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          ageList.add(new AgeModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl + "get_religion"), headers: {
      "Accept-Language": langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          relList.add(new ReligionModel.fromJson(v));
        });
      }
    }
  }

  getCity(stateId) async {
    var res = await http.post(Uri.parse(baseUrl + "getDistrict"), body: {
      "state_id": stateId
    }, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      cityList.clear();
    });
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          cityList.add(new CityModel.fromJson(v));
        });
      }
    }
  }

  getSub(castId) async {
    var res = await http.post(Uri.parse(baseUrl + "getSubcaste"), body: {
      "cast_id": castId
    }, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      subList.clear();
    });
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          subList.add(new SubCastModel.fromJson(v));
        });
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
          backgroundColor: Colors.white,
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
          body: Stack(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 350.toPercentLength.value,
                        child: Image.asset(
                          LOGIN_BACKGRAUND,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  )),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    boxHeight(95),
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, right: 30, left: 30, bottom: 10),
                      child: text("Partner Basic Info",
                          fontSize: 15.0,
                          fontFamily: fontMedium,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, right: 30, left: 30, bottom: 20),
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: <Widget>[
                            ageList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child: DropdownButtonHideUnderline(
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
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: ageList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.title,
                                                  child: Text(
                                                    item.title.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontMedium,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffc5c4c7),
                                            //36325A
                                          ),
                                          color: Colors.white,
                                          //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                        ),
                                        //buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownMaxHeight: 200,
                                        //   dropdownWidth: 350,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color(0xff211D4A),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        /*offset: const Offset(20, 0),*/
                                      ),
                                    ))
                                : SizedBox(),
                            heightList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Your Height",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: fontMedium,
                                                  color: Colors.black,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: heightList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.id.toString(),
                                                  child: Text(
                                                    item.height.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontMedium,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: heightId,
                                        onChanged: (value) {
                                          setState(() {
                                            heightId = value.toString();
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffc5c4c7),
                                            //36325A
                                          ),
                                          color: Colors.white,
                                          //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                        ),
                                        //buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownMaxHeight: 200,
                                        //   dropdownWidth: 350,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color(0xff211D4A),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        /*offset: const Offset(20, 0),*/
                                      ),
                                    ))
                                : SizedBox(),
                            dietList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Your Diet",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: fontMedium,
                                                  color: Colors.black,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: dietList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.diet,
                                                  child: Text(
                                                    item.diet.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontMedium,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: dietId,
                                        onChanged: (value) {
                                          setState(() {
                                            dietId = value.toString();
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffc5c4c7),
                                            //36325A
                                          ),
                                          color: Colors.white,
                                          //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                        ),
                                        //buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownMaxHeight: 200,
                                        //   dropdownWidth: 350,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color(0xff211D4A),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        /*offset: const Offset(20, 0),*/
                                      ),
                                    ))
                                : SizedBox(),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Your marital status",
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
                                    items: statusList
                                        .map((item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: fontMedium,
                                                  color: Colors.black,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: marry,
                                    onChanged: (value) {
                                      setState(() {
                                        marry = value.toString();
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
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
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
                                    itemPadding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    dropdownMaxHeight: 200,
                                    //   dropdownWidth: 350,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      //color: Color(0xff211D4A),
                                    ),
                                    dropdownElevation: 8,
                                    scrollbarRadius:
                                        const Radius.circular(40),
                                    scrollbarThickness: 5,
                                    scrollbarAlwaysShow: true,
                                    /*offset: const Offset(20, 0),*/
                                  ),
                                )),
                            relList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child: DropdownButtonHideUnderline(
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
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: relList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value:
                                                      item.region.toString(),
                                                  child: Text(
                                                    item.region.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontMedium,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffc5c4c7),
                                            //36325A
                                          ),
                                          color: Colors.white,
                                          //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                        ),
                                        //buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownMaxHeight: 200,
                                        //   dropdownWidth: 350,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color(0xff211D4A),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        /*offset: const Offset(20, 0),*/
                                      ),
                                    ))
                                : SizedBox(),
                            langList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Preferred Language",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: fontMedium,
                                                  color: Colors.black,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: langList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.languageName,
                                                  child: Text(
                                                    item.languageName
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontMedium,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: langId,
                                        onChanged: (value) {
                                          setState(() {
                                            langId = value.toString();
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffc5c4c7),
                                            //36325A
                                          ),
                                          color: Colors.white,
                                          //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                        ),
                                        //buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownMaxHeight: 200,
                                        //   dropdownWidth: 350,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color(0xff211D4A),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        /*offset: const Offset(20, 0),*/
                                      ),
                                    ))
                                : SizedBox(),
                            manglicList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Manglik",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: fontMedium,
                                                  color: Colors.black,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: manglicList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.manglik,
                                                  child: Text(
                                                    item.manglik.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontMedium,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: manglicId,
                                        onChanged: (value) {
                                          setState(() {
                                            manglicId = value.toString();
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffc5c4c7),
                                            //36325A
                                          ),
                                          color: Colors.white,
                                          //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                        ),
                                        //buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownMaxHeight: 200,
                                        //   dropdownWidth: 350,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color(0xff211D4A),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        /*offset: const Offset(20, 0),*/
                                      ),
                                    ))
                                : SizedBox(),
                            gotraList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Gotra",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: fontMedium,
                                                  color: Colors.black,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: gotraList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.title,
                                                  child: Text(
                                                    item.title.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontMedium,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: gotraId,
                                        onChanged: (value) {
                                          setState(() {
                                            gotraId = value.toString();
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffc5c4c7),
                                            //36325A
                                          ),
                                          color: Colors.white,
                                          //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                        ),
                                        //buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownMaxHeight: 200,
                                        //   dropdownWidth: 350,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color(0xff211D4A),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        /*offset: const Offset(20, 0),*/
                                      ),
                                    ))
                                : SizedBox(),
                            drinkList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Drinking and Smoking",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: fontMedium,
                                                  color: Colors.black,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: drinkList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.drinkingSmoking,
                                                  child: Text(
                                                    item.drinkingSmoking
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontMedium,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffc5c4c7),
                                            //36325A
                                          ),
                                          color: Colors.white,
                                          //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                        ),
                                        //buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownMaxHeight: 200,
                                        //   dropdownWidth: 350,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color(0xff211D4A),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        /*offset: const Offset(20, 0),*/
                                      ),
                                    ))
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, right: 30, left: 30, bottom: 10),
                      child: text("Partner Location",
                          fontSize: 15.0,
                          fontFamily: fontMedium,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, right: 30, left: 30, bottom: 20),
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: <Widget>[
                            stateList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    // child: DropdownButtonHideUnderline(
                                    //   child: DropdownButton2(
                                    //     isExpanded: true,
                                    //     hint: Row(
                                    //       children: const [
                                    //         SizedBox(
                                    //           width: 4,
                                    //         ),
                                    //         Expanded(
                                    //           child: Text(
                                    //             "Select State",
                                    //             style: TextStyle(
                                    //               fontSize: 14,
                                    //               fontWeight: FontWeight.w400,
                                    //               fontFamily: fontMedium,
                                    //               color: Colors.black,
                                    //             ),
                                    //             overflow:
                                    //                 TextOverflow.ellipsis,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     items: stateList
                                    //         .map((item) =>
                                    //             DropdownMenuItem<String>(
                                    //               value: item.name,
                                    //               child: Text(
                                    //                 item.name.toString(),
                                    //                 style: const TextStyle(
                                    //                   fontSize: 14,
                                    //                   fontFamily: fontMedium,
                                    //                   color: Colors.black,
                                    //                 ),
                                    //                 overflow:
                                    //                     TextOverflow.ellipsis,
                                    //               ),
                                    //             ))
                                    //         .toList(),
                                    //     value: stateId,
                                    //     onChanged: (value) {
                                    //       setState(() {
                                    //         stateId = value.toString();
                                    //       });
                                    //       int i = stateList.indexWhere(
                                    //           (element) =>
                                    //               element.name == stateId);
                                    //       getCity(stateList[i].id);
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
                                    //     buttonPadding: const EdgeInsets.only(
                                    //         left: 14, right: 14),
                                    //     dropdownPadding: EdgeInsets.only(
                                    //         left: 14, right: 14),
                                    //     buttonDecoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(10),
                                    //       border: Border.all(
                                    //         color: Color(0xffc5c4c7),
                                    //         //36325A
                                    //       ),
                                    //       color: Colors.white,
                                    //       //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                    //     ),
                                    //     //buttonElevation: 2,
                                    //     itemHeight: 40,
                                    //     itemPadding: EdgeInsets.only(
                                    //         left: 10, right: 10),
                                    //     dropdownMaxHeight: 200,
                                    //     //   dropdownWidth: 350,
                                    //     dropdownDecoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(5),
                                    //       //color: Color(0xff211D4A),
                                    //     ),
                                    //     dropdownElevation: 8,
                                    //     scrollbarRadius:
                                    //         const Radius.circular(40),
                                    //     scrollbarThickness: 5,
                                    //     scrollbarAlwaysShow: true,
                                    //     /*offset: const Offset(20, 0),*/
                                    //   ),
                                    // )
                              child:   DropdownSearch<StateModel>(
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
                                  if(instance.name!.toLowerCase().contains(filter)){
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
                            )
                                : SizedBox(),
                            cityList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child:
                                    // DropdownButtonHideUnderline(
                                    //   child: DropdownButton2(
                                    //     isExpanded: true,
                                    //     hint: Row(
                                    //       children: const [
                                    //         SizedBox(
                                    //           width: 4,
                                    //         ),
                                    //         Expanded(
                                    //           child: Text(
                                    //             "Select City",
                                    //             style: TextStyle(
                                    //               fontSize: 14,
                                    //               fontWeight: FontWeight.w400,
                                    //               fontFamily: fontMedium,
                                    //               color: Colors.black,
                                    //             ),
                                    //             overflow:
                                    //                 TextOverflow.ellipsis,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     items: cityList
                                    //         .map((item) =>
                                    //             DropdownMenuItem<String>(
                                    //               value: item.name,
                                    //               child: Text(
                                    //                 item.name.toString(),
                                    //                 style: const TextStyle(
                                    //                   fontSize: 14,
                                    //                   fontFamily: fontMedium,
                                    //                   color: Colors.black,
                                    //                 ),
                                    //                 overflow:
                                    //                     TextOverflow.ellipsis,
                                    //               ),
                                    //             ))
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
                                    //     buttonPadding: const EdgeInsets.only(
                                    //         left: 14, right: 14),
                                    //     dropdownPadding: EdgeInsets.only(
                                    //         left: 14, right: 14),
                                    //     buttonDecoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(10),
                                    //       border: Border.all(
                                    //         color: Color(0xffc5c4c7),
                                    //         //36325A
                                    //       ),
                                    //       color: Colors.white,
                                    //       //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                    //     ),
                                    //     //buttonElevation: 2,
                                    //     itemHeight: 40,
                                    //     itemPadding: EdgeInsets.only(
                                    //         left: 10, right: 10),
                                    //     dropdownMaxHeight: 200,
                                    //     //   dropdownWidth: 350,
                                    //     dropdownDecoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(5),
                                    //       //color: Color(0xff211D4A),
                                    //     ),
                                    //     dropdownElevation: 8,
                                    //     scrollbarRadius:
                                    //         const Radius.circular(40),
                                    //     scrollbarThickness: 5,
                                    //     scrollbarAlwaysShow: true,
                                    //     /*offset: const Offset(20, 0),*/
                                    //   ),
                                    // )
                                    DropdownSearch<CityModel>(
                                      mode: Mode.DIALOG,
                                      showSelectedItem:false,
                                      items: cityList,
                                      itemAsString: (CityModel u) => u.name.toString(),
                                      hint: "select City",
                                      onChanged: (value){
                                        cityId = value!.id.toString();
                                        setState(() {
                                          //getCity(stateId);
                                        });
                                        print("selected country id" + value.id.toString());
                                      },
                                      showSearchBox: true,
                                      filterFn: (instance, filter){
                                        if(instance.name!.toLowerCase().contains(filter)){
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
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, right: 30, left: 30, bottom: 10),
                      child: text("Partner Education & Career",
                          fontSize: 15.0,
                          fontFamily: fontMedium,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, right: 30, left: 30, bottom: 20),
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left:20,right:20,top: 10),
                              height: 45,
                                child:TextFormField(
                                  controller: qualificationController,
                                  decoration:InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                    hintText: "Enter highest qualification",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.white.withOpacity(0.6))
                                    )
                                  )
                                )
                            ),
                            Container(
                                margin: EdgeInsets.only(left:20,right:20,top: 10),
                                height: 45,
                                child:TextFormField(
                                    controller: occupationController,
                                    decoration:InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                        hintText: "Enter Occupation",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.white.withOpacity(0.6))
                                        )
                                    )
                                )
                            ),
                            // quaList.length > 0
                            //     ? Padding(
                            //         padding: EdgeInsets.symmetric(
                            //             vertical: 10,
                            //             horizontal: MediaQuery.of(context)
                            //                     .size
                            //                     .height *
                            //                 0.03),
                            //         child: DropdownButtonHideUnderline(
                            //           child: DropdownButton2(
                            //             isExpanded: true,
                            //             hint: Row(
                            //               children: const [
                            //                 SizedBox(
                            //                   width: 4,
                            //                 ),
                            //                 Expanded(
                            //                   child: Text(
                            //                     "Your Highest Qualification",
                            //                     style: TextStyle(
                            //                       fontSize: 14,
                            //                       fontWeight: FontWeight.w400,
                            //                       fontFamily: fontMedium,
                            //                       color: Colors.black,
                            //                     ),
                            //                     overflow:
                            //                         TextOverflow.ellipsis,
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //             items: quaList
                            //                 .map((item) =>
                            //                     DropdownMenuItem<String>(
                            //                       value: item.title,
                            //                       child: Text(
                            //                         item.title.toString(),
                            //                         style: const TextStyle(
                            //                           fontSize: 14,
                            //                           fontFamily: fontMedium,
                            //                           color: Colors.black,
                            //                         ),
                            //                         overflow:
                            //                             TextOverflow.ellipsis,
                            //                       ),
                            //                     ))
                            //                 .toList(),
                            //             value: quaId,
                            //             onChanged: (value) {
                            //               setState(() {
                            //                 quaId = value.toString();
                            //               });
                            //             },
                            //             icon: const Icon(
                            //               Icons.keyboard_arrow_down,
                            //               color: Colors.black,
                            //             ),
                            //             iconOnClick: const Icon(
                            //               Icons.keyboard_arrow_up,
                            //               color: Colors.black,
                            //             ),
                            //             iconSize: 14,
                            //             iconEnabledColor: Colors.white,
                            //             iconDisabledColor: Colors.grey,
                            //             buttonHeight: 50,
                            //             buttonWidth: double.infinity,
                            //             buttonPadding: const EdgeInsets.only(
                            //                 left: 14, right: 14),
                            //             dropdownPadding: EdgeInsets.only(
                            //                 left: 14, right: 14),
                            //             buttonDecoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //               border: Border.all(
                            //                 color: Color(0xffc5c4c7),
                            //                 //36325A
                            //               ),
                            //               color: Colors.white,
                            //               //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                            //             ),
                            //             //buttonElevation: 2,
                            //             itemHeight: 40,
                            //             itemPadding: EdgeInsets.only(
                            //                 left: 10, right: 10),
                            //             dropdownMaxHeight: 200,
                            //             //   dropdownWidth: 350,
                            //             dropdownDecoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(5),
                            //               //color: Color(0xff211D4A),
                            //             ),
                            //             dropdownElevation: 8,
                            //             scrollbarRadius:
                            //                 const Radius.circular(40),
                            //             scrollbarThickness: 5,
                            //             scrollbarAlwaysShow: true,
                            //             /*offset: const Offset(20, 0),*/
                            //           ),
                            //         ))
                            //     : SizedBox(),
                            // occList.length > 0
                            //     ? Padding(
                            //         padding: EdgeInsets.symmetric(
                            //             vertical: 10,
                            //             horizontal: MediaQuery.of(context)
                            //                     .size
                            //                     .height *
                            //                 0.03),
                            //         child: DropdownButtonHideUnderline(
                            //           child: DropdownButton2(
                            //             isExpanded: true,
                            //             hint: Row(
                            //               children: const [
                            //                 SizedBox(
                            //                   width: 4,
                            //                 ),
                            //                 Expanded(
                            //                   child: Text(
                            //                     "Occupation",
                            //                     style: TextStyle(
                            //                       fontSize: 14,
                            //                       fontWeight: FontWeight.w400,
                            //                       fontFamily: fontMedium,
                            //                       color: Colors.black,
                            //                     ),
                            //                     overflow:
                            //                         TextOverflow.ellipsis,
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //             items: occList
                            //                 .map((item) =>
                            //                     DropdownMenuItem<String>(
                            //                       value: item.occupation,
                            //                       child: Text(
                            //                         item.occupation
                            //                             .toString(),
                            //                         style: const TextStyle(
                            //                           fontSize: 14,
                            //                           fontFamily: fontMedium,
                            //                           color: Colors.black,
                            //                         ),
                            //                         overflow:
                            //                             TextOverflow.ellipsis,
                            //                       ),
                            //                     ))
                            //                 .toList(),
                            //             value: occId,
                            //             onChanged: (value) {
                            //               setState(() {
                            //                 occId = value.toString();
                            //               });
                            //             },
                            //             icon: const Icon(
                            //               Icons.keyboard_arrow_down,
                            //               color: Colors.black,
                            //             ),
                            //             iconOnClick: const Icon(
                            //               Icons.keyboard_arrow_up,
                            //               color: Colors.black,
                            //             ),
                            //             iconSize: 14,
                            //             iconEnabledColor: Colors.white,
                            //             iconDisabledColor: Colors.grey,
                            //             buttonHeight: 50,
                            //             buttonWidth: double.infinity,
                            //             buttonPadding: const EdgeInsets.only(
                            //                 left: 14, right: 14),
                            //             dropdownPadding: EdgeInsets.only(
                            //                 left: 14, right: 14),
                            //             buttonDecoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //               border: Border.all(
                            //                 color: Color(0xffc5c4c7),
                            //                 //36325A
                            //               ),
                            //               color: Colors.white,
                            //               //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                            //             ),
                            //             //buttonElevation: 2,
                            //             itemHeight: 40,
                            //             itemPadding: EdgeInsets.only(
                            //                 left: 10, right: 10),
                            //             dropdownMaxHeight: 200,
                            //             //   dropdownWidth: 350,
                            //             dropdownDecoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(5),
                            //               //color: Color(0xff211D4A),
                            //             ),
                            //             dropdownElevation: 8,
                            //             scrollbarRadius:
                            //                 const Radius.circular(40),
                            //             scrollbarThickness: 5,
                            //             scrollbarAlwaysShow: true,
                            //             /*offset: const Offset(20, 0),*/
                            //           ),
                            //         ))
                            //     : SizedBox(),
                            incomeList.length > 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.03),
                                    child: DropdownButtonHideUnderline(
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
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: incomeList
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.income,
                                                  child: Text(
                                                    item.income.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: fontMedium,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffc5c4c7),
                                            //36325A
                                          ),
                                          color: Colors.white,
                                          //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                        ),
                                        //buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        dropdownMaxHeight: 200,
                                        //   dropdownWidth: 350,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //color: Color(0xff211D4A),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        /*offset: const Offset(20, 0),*/
                                      ),
                                    ))
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    boxHeight(70),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (ageId == null) {
                            setSnackbar("Please Select Age", context);
                            return;
                          }
                          if (heightId == null) {
                            setSnackbar("Please Select Height", context);
                            return;
                          }
                          if (dietId == null) {
                            setSnackbar("Please Select Diet", context);
                            return;
                          }
                          if (marry == null) {
                            setSnackbar(
                                "Please Select Marital Status", context);
                            return;
                          }
                          if (langId == null) {
                            setSnackbar("Please Select Language", context);
                            return;
                          }
                          if (manglicId == null) {
                            setSnackbar("Please Select Manglik", context);
                            return;
                          }
                          if (gotraId == null) {
                            setSnackbar("Please Select Gotra", context);
                            return;
                          }
                          if (drinkId == null) {
                            setSnackbar(
                                "Please Select Drinking Status", context);
                            return;
                          }
                          if (stateId == null) {
                            setSnackbar("Please Select State", context);
                            return;
                          }
                          if (cityId == null) {
                            setSnackbar("Please Select City", context);
                            return;
                          }

                          if (qualificationController.text.isEmpty) {
                            setSnackbar(
                                "Please Enter Qualification", context);
                            return;
                          }
                          if (occupationController.text.isEmpty) {
                            setSnackbar("Please Enter Occupation", context);
                            return;
                          }
                          if (incomeId == null) {
                            setSnackbar("Please Select Income", context);
                            return;
                          }

                          setState(() {
                            loading = true;
                          });
                          register();
                        },
                        child: Container(
                          width: getWidth(625),
                          height: getHeight(95),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [
                                  0,
                                  1
                                ],
                                colors: <Color>[
                                  Color(0xffF72D2D),
                                  Color(0xffF5F049),
                                ]),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: !loading
                                ? text("Update",
                                    fontFamily: fontMedium,
                                    fontSize: 14.sp,
                                    textColor: Colors.white)
                                : loadingWidget(),
                          ),
                        ),
                      ),
                    ),
                    boxHeight(59),
                  ],
                ),
              )
            ],
          )),
    );
  }

  bool loading = false;
  register() async {
    Map param = {
      "age": ageId.toString(),
      "height": heightId.toString(),
      "marital_status": marry.toString(),
      "mother_tongue": langId.toString(),
      "physical_status": physical.toString(),
      "smoking": drinkId.toString(),
      "drinking": drinkId.toString(),
      "religion": relId.toString(),
      "caste": castId.toString(),
      "subcaste": subId.toString(),
      "dosh": doshId.toString(),
      "gotra": gotraId.toString(),
      "occuption": occupationController.text,
      "manglik": manglicId.toString(),
      "working_as": workingId.toString(),
      "annual_income": incomeId.toString(),
      "state": stateId.toString(),
      "city": cityId.toString(),
      "user_id": curUserId,
    };
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "add_prefrence"), body: param, headers: {
      "Accept-Language": langCode,
    });
    print(res.body);
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardView(0)),
          (route) => false);
    } else {}
  }
}
