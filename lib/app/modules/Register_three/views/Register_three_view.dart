import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/Register_four/views/Register_four_view.dart';
import 'package:indianmilan/app/modules/Register_three/controllers/Register_three_cotroller.dart';
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

import '../../../global_widgets/textfield_ui.dart';
class Register_three_view extends StatefulWidget {
  var param;


  Register_three_view(this.param);

  @override
  _Register_three_viewState createState() => _Register_three_viewState();
}

class _Register_three_viewState extends State<Register_three_view> {
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
    param = widget.param;
    if(model!=null){
     /* if(model!.state!=null&&model!.state!=""){
        stateId = model!.state.toString();
      }*/
      /*if(model!.city!=null&&model!.city!=""){
        cityId = model!.city.toString();
      }*/
      if(model!.maritalStatus!=null&&model!.maritalStatus!=""){
        if(!model!.maritalStatus.toString().toLowerCase().contains("married"))
        marry = model!.maritalStatus.toString()=="Yes"?"Married":"Unmarried";
        else
          marry = model!.maritalStatus.toString();
      }
     /* if(model!.caste!=null&&model!.caste!=""){
        castId = model!.caste.toString();
      }*/
     /* if(model!.subId!=null&&model!.subId!=""){
        subId = model!.subId.toString();
      }*/
      /*if(model!.gotra!=null&&model!.gotra!=""){
        gotraId = model!.gotra.toString();
      }*/
      if(model!.manglik!=null&&model!.manglik!=""){
        manglicId = model!.manglik.toString();
      }
    /*  if(model!.height!=null&&model!.height!=""){
        heightId = model!.height.toString();
      }*/
     /* if(model!.dosh!=null&&model!.dosh!=""){
        doshId = model!.dosh.toString();
      }*/
      if(model!.language!=null&&model!.language!=""){
        langId = model!.language.toString();
      }
      if(model!.dietary!=null&&model!.dietary!=""){
        dietId = model!.dietary.toString();
      }
      /*if(model!.!=null&&model!.physicalStatus!=""){
        physical = model!.physicalStatus.toString();
      }*/
    }

  }
  List<StateModel> stateList = [];
  List<CityModel> cityList = [];
  List<String> statusList = ["Married","Unmarried"];
  List<String> phyList = ["Yes","No"];
  List<CastModel> castList = [];
  List<SubCastModel> subList = [];
  List<GotraModel> gotraList = [];
  List<ManglicModel> manglicList = [];
  List<HeightModel> heightList = [];
  List<DoshModel> doshList = [];
  List<langModel> langList = [];
  List<langModel> motherList = [];
  List<dietModel> dietList = [];
  String? stateId,cityId,marry,castId,subId,gotraId,manglicId,heightId,doshId,langId,dietId,physical,mother_tongue;
  getData()async{
    var res = await http.get(Uri.parse(baseUrl+"getStates"),headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          stateList.add(new StateModel.fromJson(v));
        });

      }
      if(model!=null)
      setState(() {
        if(model!.state!=null&&model!.state!=""){
          int i = stateList.indexWhere((element) => element.name==model!.state.toString());
          if(i!=-1){
            stateId = stateList[i].id;
            getCity(stateId);
          }
        }
      });
    }
    res = await http.get(Uri.parse(baseUrl+"getCaste"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          castList.add(new CastModel.fromJson(v));
        });
      }
      if(model!=null)
      setState(() {
        if(model!.caste!=null&&model!.caste!=""){
          int i = castList.indexWhere((element) => element.caste==model!.caste.toString());
          if(i!=-1){
            castId = castList[i].casteId;
          }

        }
      });
    }
    res = await http.get(Uri.parse(baseUrl+"gontra"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          gotraList.add(new GotraModel.fromJson(v));
          if(model!=null){
            if(model!.gotra.toString().toLowerCase()==v['title'].toString().toLowerCase()){
              gotraId = v['id'].toString().toLowerCase();
            }
          }
        });

      }
    }
    res = await http.get(Uri.parse(baseUrl+"getManglik"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          manglicList.add(new ManglicModel.fromJson(v));
        });
      }
      if(model!=null)
      setState(() {
        if(model!.manglik!=null&&model!.manglik!=""){
          int i = manglicList.indexWhere((element) => element.manglik==model!.manglik.toString());
          if(i!=-1){
            manglicId = manglicList[i].manglikId;
          }

        }
      });
    }
    res = await http.get(Uri.parse(baseUrl+"getHeight"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          heightList.add(new HeightModel.fromJson(v));
        });
      }
      if(model!=null)
        setState(() {
          if(model!.height!=null&&model!.height!=""){
            int i = heightList.indexWhere((element) => element.height==model!.height.toString());
            if(i!=-1){
              heightId = heightList[i].id;
            }

          } });
    }
    res = await http.get(Uri.parse(baseUrl+"mm_dosh"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          doshList.add(new DoshModel.fromJson(v));
        });
        if(model!=null){
          if(model!.dosh.toString().toLowerCase()==v['title'].toString().toLowerCase()){
            doshId = v['id'].toString().toLowerCase();
          }
        }
      }
    }
    res = await http.get(Uri.parse(baseUrl+"getLanguage"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          langList.add(new langModel.fromJson(v));
          motherList.add(new langModel.fromJson(v));
          if(model!=null){
            if(model!.motherTongue.toString().toLowerCase()==v['language_name'].toString().toLowerCase()){
              mother_tongue = v['language_name'].toString();
            }
          }
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"mm_diet"));
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          dietList.add(new dietModel.fromJson(v));
        });
      }
    }
    res = await http.get(Uri.parse(baseUrl+"physical"),headers: {
      "Accept-Language" : langCode,
    });
    response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          physicalList.add(new PhysicalModel1.fromJson(v));
          if(model!=null){
            if(model!.physicalStatus.toString().toLowerCase()==v['name'].toString().toLowerCase()){
              physical = model!.physicalStatus.toString();
            }
          }
        });

      }
    }

  }
  List<PhysicalModel1> physicalList = [];
  getCity(stateId)async{
    var res = await http.post(Uri.parse(baseUrl+"get_city"),body: {"state_id":stateId},headers: {
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
            if(model!.city.toString().toLowerCase()==v['name'].toString().toLowerCase()){
              cityId = v['id'].toString().toLowerCase();
            }
          }
        });

      }
    }

  }
  getSub(castId)async{
    var res = await http.post(Uri.parse(baseUrl+"getSubcaste"),body: {"cast_id":castId},headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      subList.clear();
    });
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          subList.add(new SubCastModel.fromJson(v));
        });
      }
    }

  }

  TextEditingController weightController = TextEditingController();


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
                      text("Now Lets Build Your Profile",
                          fontFamily: fontMedium,
                          fontSize: 14.sp,
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
                            //             "Select State",
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
                       stateList == null ? SizedBox() :     DropdownSearch<StateModel>(
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
                            //             "Select City",
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
                            cityList == null ? SizedBox() :     DropdownSearch<CityModel>(
                              mode: Mode.DIALOG,
                              showSelectedItem:false,
                              items:cityList,
                              itemAsString: (CityModel u) => u.name.toString(),
                              hint: "select City",
                              onChanged: (value){
                                cityId = value!.id.toString();
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
                            boxHeight(35),
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
                             boxHeight(35),
                            // castList.length>0?DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //     hint: Row(
                            //       children: const [
                            //         SizedBox(
                            //           width: 4,
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             "Your Cast",
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
                            //     items: castList
                            //         .map((item) => DropdownMenuItem<String>(
                            //       value: item.casteId,
                            //       child: Text(
                            //         item.caste.toString(),
                            //         style: const TextStyle(
                            //           fontSize: 14,
                            //           fontFamily: fontMedium,
                            //           color: Colors.black,
                            //         ),
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ))
                            //         .toList(),
                            //     value: castId,
                            //     onChanged: (value) {
                            //      setState(() {
                            //        castId = value.toString();
                            //      });
                            //      getSub(castId);
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
                            // boxHeight(35),
                            subList.length>0?DropdownButton2(
                              isExpanded: true,
                              underline: SizedBox(),
                              hint: Row(
                                children: const [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Your Sub Caste",
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
                              items: subList
                                  .map((item) => DropdownMenuItem<String>(
                                value: item.subcaste,
                                child: Text(
                                  item.subcaste.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: fontMedium,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: subId,
                              onChanged: (value) {
                                setState(() {
                                  subId = value.toString();
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
                            ):SizedBox(),


                            boxHeight(35),
                            gotraList.length>0?DropdownButtonHideUnderline(
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
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: gotraList
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
                            doshList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Dosh",
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
                                items: doshList
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
                                value: doshId,
                                onChanged: (value) {
                                  setState(() {
                                    doshId = value.toString();
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
                            manglicList.length>0?DropdownButtonHideUnderline(
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
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: manglicList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.manglikId,
                                  child: Text(
                                    item.manglik.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: manglicId,
                                onChanged: (value) {
                                  setState(() {
                                    manglicId =  value.toString();
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
                            langList.length>0?DropdownButtonHideUnderline(
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
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: langList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.languageName,
                                  child: Text(
                                    item.languageName.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
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
                            langList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Mother Tongue",
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
                                items: langList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.languageName,
                                  child: Text(
                                    item.languageName.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: mother_tongue,
                                onChanged: (value) {
                                  setState(() {
                                    mother_tongue = value.toString();
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
                            physicalList.length>0?DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Physical Status",
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
                                items: physicalList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.name.toString(),
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
                                value: physical,
                                onChanged: (value) {
                                 setState(() {
                                   physical = value.toString();
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
                            dietList.length>0?DropdownButtonHideUnderline(
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
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: dietList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.diet,
                                  child: Text(
                                    item.diet.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
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
                            heightList.length>0?DropdownButtonHideUnderline(
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
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: heightList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.id.toString(),
                                  child: Text(
                                    item.height.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: fontMedium,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
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
                              controller: weightController,
                              maxLines: 2,
                              fontSize: 14,
                              minLines: 1,
                              hintText: "Enter your Weight",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.number,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                          ],),
                      ),
                      boxHeight(70),
                      Center(
                        child: InkWell(
                          onTap: (){
                            if(stateId==null){
                              setSnackbar("Please Select State", context);
                              return;
                            }
                            if(cityId==null){
                              setSnackbar("Please Select City", context);
                              return;
                            }
                            if(marry==null){
                              setSnackbar("Please Select Marital Status", context);
                              return;
                            }
                            // if(castId==null){
                            //   setSnackbar("Please Select Cast", context);
                            //   return;
                            // }
                            if(gotraId==null){
                              setSnackbar("Please Select Gotra", context);
                              return;
                            }
                            if(doshId==null){
                              setSnackbar("Please Select Dosh", context);
                              return;
                            }
                            if(manglicId==null){
                              setSnackbar("Please Select Manglik", context);
                              return;
                            }
                            if(langId==null){
                              setSnackbar("Please Select Language", context);
                              return;
                            }
                            if(mother_tongue==null){
                              setSnackbar("Please Select Mother Tongue", context);
                              return;
                            }
                            if(physical==null){
                              setSnackbar("Please Select Physical Status", context);
                              return;
                            }
                            if(dietId==null){
                              setSnackbar("Please Select Diet", context);
                              return;
                            }
                            if(heightId==null){
                              setSnackbar("Please Select Height", context);
                              return;
                            }
                            if(weightController.text.isEmpty){
                              setSnackbar("Please enter weight", context);
                              return;
                            }

                            param['state']= stateId;
                            param['city']= cityId;
                            param['marital_status']= marry;
                            param['caste']= castId;
                            param['sub_caste']= subId.toString();
                            param['gotra']= gotraId;
                            param['dosh']= doshId;
                            param['manglik']= manglicId;
                            param['language']= langId;
                            param['mother_tongue']= mother_tongue;
                            param['physical_status']= physical;
                            param['dietary']= dietId;
                            param['height']= heightId;
                            param['weight'] = weightController.text;
                            print("again check parameters ${param}");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_four_view(param)));
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


