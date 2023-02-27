
import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:indianmilan/app/new_screen/search_list.dart';
import 'package:indianmilan/app/utils/ApiBaseHelper.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/list_model.dart';
import 'package:indianmilan/model/register_model.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/image_helper.dart';
import 'package:http/http.dart' as http;
class SearchProfile extends StatefulWidget {
  const SearchProfile({Key? key}) : super(key: key);

  @override
  _SearchProfileState createState() => _SearchProfileState();
}

class _SearchProfileState extends State<SearchProfile> {



  TextEditingController searchController = new TextEditingController();
  List<GenderModel> genList = [];
  String? genId;
  List<StateModel> stateList = [];
  List<CityModel> cityList = [];
  List<String> statusList = ["Married","Unmarried"];
  List<CastModel> castList = [];
  List<ManglicModel> manglicList = [];
  String? stateId,cityId,marry,castId,subId,gotraId,manglicId,heightId,doshId,langId,dietId,physical;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
        });

      }
    }

  }
  getData()async{

    var res = await http.get(Uri.parse(baseUrl+"getGender"),headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          genList.add(new GenderModel.fromJson(v));
        });
       // genId = genList[0].gender;
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
        });

      }

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

    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text("Search Profile"),
        centerTitle: true,

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.red, Colors.yellow]),
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

          ),
        ],

        leading:  GestureDetector(
          onTap:(){
            Navigator.pop(context);
          },
          child:   Container(
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
            margin: EdgeInsets.only(
                left: 30, top: 20, bottom: 10, right: 30),

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
                color: Colors.white
            ),

            child: TextField(
              onSubmitted: (String value) async {
                setState(() {

                });
              },
              controller: searchController,
              autofocus: false,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Search by name',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
              ),

            ),
          ),
          genList.length>0?Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child:  DropdownButtonHideUnderline(
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
                            fontFamily: 'Lato',
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
                        fontWeight: FontWeight.w300,
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
              )
          ):SizedBox(),
          stateList.length>0?Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child:  DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "Select State",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Lato',
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: stateList
                      .map((item) => DropdownMenuItem<String>(
                    value: item.id,
                    child: Text(
                      item.name.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: stateId,
                  onChanged: (value) {
                    setState(() {
                      stateId =value.toString();
                    });
                    int i =stateList.indexWhere((element) => element.name==stateId);
                    getCity(stateId);
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
              )
          ):SizedBox(),
          cityList.length>0?Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child:  DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "Select City",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Lato',
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: cityList
                      .map((item) => DropdownMenuItem<String>(
                    value: item.name,
                    child: Text(
                      item.name.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: cityId,
                  onChanged: (value) {
                    setState(() {
                      cityId = value.toString();
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
              )
          ):SizedBox(),
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child:  DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "Marital status",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Lato',
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
                        fontWeight: FontWeight.w300,
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
              )
          ),
          castList.length>0?Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child:  DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "Your Cast",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Lato',
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: castList
                      .map((item) => DropdownMenuItem<String>(
                    value: item.casteId,
                    child: Text(
                      item.caste.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: castId,
                  onChanged: (value) {
                    setState(() {
                      castId = value.toString();
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
              )
          ):SizedBox(),
          manglicList.length>0?Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: MediaQuery.of(context).size.height * 0.03),
              child:  DropdownButtonHideUnderline(
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
                            fontFamily: 'Lato',
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
                        fontWeight: FontWeight.w300,
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
              )
          ):SizedBox(),
          InkWell(
            onTap: (){
              Map param ={};
              if(searchController.text==""){
                  setSnackbar("Please Enter Name", context);
                  return;
              }
              param['name']=searchController.text.toString();
              if(genId!=null){
                param['gender']=genId.toString();
              }
              if(castId!=null){
                param['caste']=castId.toString();
              }
              if(marry!=null){
                param['marital_status']=marry.toString();
              }
              if(manglicId!=null){
                param['manglik']=manglicId.toString();
              }
              if(stateId!=null){
                param['state']=stateId.toString();
              }
              if(cityId!=null){
                param['district']=cityId.toString();
              }
              addSearch(param);
            },
            child: Container(
              margin: EdgeInsets.only(top: 25,bottom: 10,left: 30,right: 30),
              alignment: Alignment.center,
              height: 45,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue
              ),

              child: !loading?Text("Search",style: TextStyle(color: Colors.white,fontSize: 17),):loadingWidget(color: Colors.white,),
            ),
          )



        ],
      ),

    );
  }
  bool loading = false;
  bool showWithdraw = false;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  List<UserModel> userList = [];
  addSearch(params) async {
    try {
      setState(() {
        loading = true;
      });
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "searchUsers"), params);
      setState(() {
        loading = false;
      });
      if (response['status'].toString() == "1") {
        for (var v in response['data']) {
          setState(() {
            userList.add(new UserModel.fromJson(v));
          });
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchList(userList.toList())));
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }
}
