import 'dart:async';
import 'dart:convert';

import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/Home/controllers/HomeNavigation.dart';
import 'package:indianmilan/app/modules/Login/views/login_view.dart';
import 'package:indianmilan/app/modules/My_profile_details/views/profile_view.dart';
import 'package:indianmilan/app/modules/Partner_prefrance_details/views/partner_preference_details_view.dart';
import 'package:indianmilan/app/modules/Search_profile/views/searchprofile_view.dart';
import 'package:indianmilan/app/modules/Shortlisted_Profile/views/Shortlisted_Profile_view.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/modules/splash/views/splash_view.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/ApiBaseHelper.dart';
import 'package:indianmilan/app/utils/ColorClass.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/app/utils/location_details.dart';
import 'package:indianmilan/app/utils/web_view.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/banner_model.dart';
import 'package:indianmilan/model/list_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:indianmilan/model/package_model.dart';
import 'package:indianmilan/model/profile_model.dart';
import 'package:translator/translator.dart';

class Home_view extends StatefulWidget {
  const Home_view({Key? key}) : super(key: key);

  @override
  _Home_viewState createState() => _Home_viewState();
}

class _Home_viewState extends State<Home_view> {

  final translator = GoogleTranslator();


  List<BannerModel> bannerList = [];
  List<String> filterList = ["All User", "Matches","New Join","Near Me","Online","Interest Send","Interest Received","Contact Viewed","Viewed By Me","Viewed Me"];
  String filter = "All User";
  bool loading = true,mutualLoading = true;
  bool loadingRecent = true;
  bool loadingVisit = true;
  bool loadingMatches = true;
  getData() async {
    var res = await http.get(Uri.parse(baseUrl + "getbanner"), headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loading = false;
    });
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          bannerList.add(new BannerModel.fromJson(v));
        });
      }
    }
  }

  List<UserModel> userList = [];
  getUser() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res =
        await http.post(Uri.parse(baseUrl + "justJoin"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          userList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {

      count[2] = userList.length.toString();
    });
  }

  List<UserModel> recentList = [];
  getRecent() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "get_recent_view"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loadingRecent = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          recentList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {
      count[8] = recentList.length.toString();
    });
  }
  List<UserModel> nearList = [];
  getNear() async {
    Map param = {};
    param['lat'] = latitude.toString();
    param['lang'] = longitude.toString();
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "near_me"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      nearList.clear();
    });
   // setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          nearList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {
      count[3] = nearList.length.toString();
    });
  }
  List<UserModel> matchList = [];
  getMatch() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "matchesUser"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loadingMatches = false;
      matchList.clear();
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          matchList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {
      count[1] = matchList.length.toString();
    });
  }

  List<UserModel> visitList = [];
  getVisitor() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "getVisitors"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loadingVisit = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          visitList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {
      count[9] = visitList.length.toString();
    });
  }
  List<UserModel> allList = [];
  getAll() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    print("ccc ::"+curUserId.toString());
    var res = await http
        .post(Uri.parse(baseUrl + "all_profile"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);

    //setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          allList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {
      tempList = allList.toList();
      count[0] = allList.length.toString();
    });
  }
  List<UserModel> onlineList = [];
  getOnline() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "online"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);

    //setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          onlineList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {
      count[4] = onlineList.length.toString();
    });
  }
  List<UserModel> interestList = [];
  getInterest() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "interest_sent"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);

    //setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          interestList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {
      count[5] = interestList.length.toString();
    });
  }
  List<UserModel> receiveList = [];
  getReceive() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "interest_received"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);

    //setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          receiveList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {
      count[6] = receiveList.length.toString();
    });
  }
  List<UserModel> contactList = [];
  getContact() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "contact_view"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);

    //setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        setState(() {
          contactList.add(new UserModel.fromJson(v));
        });
      }
    } else {}
    setState(() {
      count[7] = contactList.length.toString();
    });
  }
  getProfile() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "myProfile"), body: param, headers: {
      "Accept-Language": langCode,
    });
    print(Uri.parse(baseUrl + "myProfile"));
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      var v = response['data'];
      setState(() {
        model = new ProfileModel.fromJson(v);
      });
      callChat();
    } else {}
  }

  getSubscription() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "subscriptionCheck"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      var v = response['data'];
      setState(() {
        historyModel = HistoryModel.fromJson(v);
      });
    } else {}
  }
  List<MutualModel> mutualList = [];
  getMutual() async {
    Map param = {};
    param['user_id'] = curUserId;
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "matchesUserimages"), body: param, headers: {
      "Accept-Language": langCode,
    });
    print(res.body);
    Map response = jsonDecode(res.body);

    setState(() {
      mutualLoading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      var v = response['data'];
      for(var v in response['data'])
      setState(() {
        mutualList.add(MutualModel.fromJson(v));
      });
    } else {}
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetLocation location = new GetLocation((result){
      if(mounted){
        setState(() {
          address = result.first.addressLine;

        });
      }
      if(latitude!=result.first.coordinates.latitude){
        latitude = result.first.coordinates.latitude;
        longitude = result.first.coordinates.longitude;
        getNear();
      }

    });
    location.getLoc();
    getProfile();
    getVisitor();
    getNear();
    getMatch();
    getRecent();
    getAll();
    getContact();
    getInterest();
    getReceive();
    getOnline();
    getData();
    getUser();
    getSubscription();
    getMutual();
  }
  List<String> count = ["0", "0", "0","0","0","0", "0", "0","0","0"];
  List<UserModel> tempList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
     /* appBar: AppBar(
        title: TextFieldShow(
          color: Colors.white,
          text: address,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
          fontsize: 14,
        ),
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
              onTap: () {
                Get.toNamed(Routes.Notofication_screen);
              },
              child: Container(
                margin: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                ),
              )),
        ],
      ),*/
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchProfile()));
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Card(
                          margin: EdgeInsets.only(top: 20, left: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          elevation: 2,
                          child: model != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    child: commonImage(model!.userAvtar, 60.0,
                                        60.0, "", context, PROFILE),
                                  ),
                                )
                              : SizedBox(),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 10),
                          child: Text(
                            "Find Your Life Partner",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchProfile()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20, top: 20),
                      child: Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          count.length == filterList.length
              ? Container(
                  height: 60,
                  margin: EdgeInsets.only(
                    left: 10,
                    top: 20,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: filterList.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {

                        if(int.parse(count[index])>0){
                          setState(() {
                            filter = filterList[index];
                          });
                          if(index==0){
                            setState(() {
                              tempList = allList.toList();
                            });
                          }else if(index==1){
                            setState(() {
                              tempList = matchList.toList();
                            });
                          }else if(index==2){
                            setState(() {
                              tempList = userList.toList();
                            });
                          }else if(index==3){
                            setState(() {
                              tempList = nearList.toList();
                            });
                          }else if(index==4){
                            setState(() {
                              tempList = onlineList.toList();
                            });
                          }else if(index==5){
                            setState(() {
                              tempList = interestList.toList();
                            });
                          }else if(index==6){
                            setState(() {
                              tempList = receiveList.toList();
                            });
                          }else if(index==7){
                            setState(() {
                              tempList = contactList.toList();
                            });
                          }else if(index==8){
                            setState(() {
                              tempList = recentList.toList();
                            });
                          }else{
                            setState(() {
                              tempList = visitList.toList();
                            });
                          }
                        }else{
                          setSnackbar("No Data Available", context);
                        }
                      },
                      child: Card(
                        margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        child: Container(
                          width: getWidth(300),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0,1],
                                colors: <Color>[filter == filterList[index]?Color(0xffF72D2D):Colors.white, filter == filterList[index]?Color(0xffF72D2D):Colors.white,]),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Text(
                                  filterList[index],
                                  style: TextStyle(
                                      color: filter == filterList[index]
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      filter == filterList[index]?"assets/like.png":"assets/heart.png",
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    count[index],
                                    style: TextStyle(
                                        color: filter == filterList[index]?Colors.black:Colors.white, fontSize: 10.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : loadingWidget(),
          tempList.length > 0
              ? Container(
                  height: 340,
                  margin: EdgeInsets.only(top: 25, left: 10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: tempList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          profile_view_view(tempList[index])));
                              // Profile_details_screen
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: boxDecoration(
                                          radius: 20,
                                          color: Colors.grey,
                                          showShadow: true),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: commonImage(
                                            tempList[index].userAvtar,
                                            330.0,
                                            330.0,
                                            Girls,
                                            context,
                                            Girls),
                                      ),
                                    ),
                                    /*Container(
                                width: 330,
                                // margin: EdgeInsets.only(left: 10,right: 10),
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: new DecorationImage(image: new AssetImage(Girls),),
                                ),
                              ),*/

                                    Positioned(
                                      bottom: 10,
                                      child: Container(
                                        width: 330,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, top: 20),
                                              child: Text(
                                                tempList[index].name!,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, top: 1),
                                              child: tempList[index].age == null || tempList[index].age == "" ? Text("Age",style: TextStyle(color: Colors.white),) : Text(
                                                "Age ${tempList[index].age.toString()} | ${tempList[index].height.toString()}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, top: 1),
                                              child: Text(
                                                "${tempList[index].occupation.toString()}-${tempList[index].income.toString()}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              margin: EdgeInsets.only(
                                                  left: 20, top: 1, bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "${tempList[index].city.toString()},${tempList[index].state.toString()}",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      maxLines: 3,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                )
              : Container(
            height: 340,
            child: Center(child: loadingWidget(),),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, top: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Recently View",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          !loadingRecent
              ? recentList.length > 0
                  ? Container(
                      height: 160,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: recentList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              profile_view_view(recentList[index])));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  margin: EdgeInsets.only(left: 15),
                                  child: Container(
                                    width: getWidth(550),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: commonImage(recentList[index].userAvtar, 150.0, 120.0, "", context, Girls),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              child: Text(
                                                getString1(recentList[index].name.toString()),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              child: Text(
                                                "${getString1(recentList[index].age.toString())}yrs | ${getString1(recentList[index].height.toString())}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              child: Text(
                                                "${getString1(recentList[index].familyStatus.toString())}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.red),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              child: Text(
                                                "${getString1(recentList[index].income.toString())}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, top: 15),
                                              alignment: Alignment.center,
                                              height: 26,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.red),
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              child: Text(
                                                "Connect Now",
                                                style:
                                                    TextStyle(color: Colors.red),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    )
                  : Center(
                      child: text("No Recent View",
                          fontSize: 12.0,
                          fontFamily: fontMedium,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w700))
              : Center(
                  child: loadingWidget(),
                ),
          bannerList.length > 0
              ? Container(
                  height: 160,
                  margin: EdgeInsets.only(left: 10, top: 25),
                  child: ListView.builder(

                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: bannerList.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: EdgeInsets.only(left: 15),
                            child: Container(
                                width: 300,
                                child: Image.network(
                                  "${imageUrl}" +
                                      bannerList[index].image.toString(),
                                  fit: BoxFit.fill,
                                )),
                          )),
                )
              : SizedBox(),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Profile Visitors",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),

                /*Container(
                  child: Text("View All",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                )*/
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          !loadingVisit?visitList.length > 0
              ? Container(
                  height: 210,
                  margin: EdgeInsets.only(left: 10, top: 5),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: visitList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile_view_view(visitList[index])));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            decoration: boxDecoration(
                                radius: 20,
                                color: Colors.grey,
                                showShadow: true),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: commonImage(visitList[index].userAvtar,
                                  150.0, 190.0, Girls, context, Girls),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    getString1(
                                        visitList[index].name.toString()),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1),
                                  child: Text(
                                      "${getString1(visitList[index].age.toString())}yrs | ${getString1(visitList[index].height.toString())}\n${getString1(visitList[index].city.toString())},${getString1(visitList[index].state.toString())}"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
            width: 150,
                child: Center(
                    child: text("No Visitors",
                        fontSize: 12.0,
                        fontFamily: fontMedium,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w700)),
              ): Center(
    child: loadingWidget(),
    ),
          Container(
            // margin: EdgeInsets.only(top: 1),
            child: Divider(
              color: Colors.black,
            ),
          ),
          !mutualLoading?mutualList.length>0?Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red[50],
            ),
            margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Mutual Matches",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: getWidth(300),
                        height: getHeight(100),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 30,
                              child: Container(
                                height: 70,
                                width: 100,
                                child: commonImage(mutualList.length>0?mutualList[0].userAvtar:"", 70.0, 100.0, placeHolder, context, PROFILE),
                              ),
                            ),
                            Positioned(
                              left: 50,
                              child: Container(
                                height: 70,
                                width: 100,
                                child: commonImage(mutualList.length>1?mutualList[1].userAvtar:"", 70.0, 100.0, placeHolder, context, PROFILE),
                              ),
                            ),
                            Positioned(
                              left: 70,
                              child: Container(
                                height: 70,
                                width: 100,
                                child: commonImage(mutualList.length>2?mutualList[2].userAvtar:"", 70.0, 100.0, placeHolder, context, PROFILE),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: getWidth(300),
                        height: getHeight(100),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 30,
                              child: Container(
                                height: 70,
                                width: 100,
                                child: commonImage(mutualList.length>3?mutualList[3].userAvtar:"", 70.0, 100.0, placeHolder, context, PROFILE),
                              ),
                            ),
                            Positioned(
                              right: 50,
                              child: Container(
                                height: 70,
                                width: 100,
                                child: commonImage(mutualList.length>4?mutualList[4].userAvtar:"", 70.0, 100.0, placeHolder, context, PROFILE),
                              ),
                            ),
                            Positioned(
                              right: 70,
                              child: Container(
                                height: 70,
                                width: 100,
                                child: commonImage(mutualList.length>5?mutualList[5].userAvtar:"", 70.0, 100.0, placeHolder, context, PROFILE),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardView(1)),
                            (route) => false);
                  },
                  child: Container(
                    child: Text(
                      "See All",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ):SizedBox():Container(
              height: getHeight(100),
              child: Center(child: loadingWidget())),
          mutualList.length>0?Container(
            child: Divider(
              color: Colors.black,
            ),
          ):SizedBox(),
          Container(
            margin: EdgeInsets.only(left: 20, top: 5),
            child: Text(
              "${matchList.length} matches based on your preferences",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          matchList.length > 0
              ? Container(
                  height: 110,
                  margin: EdgeInsets.only(left: 10, top: 15),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: matchList.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      profile_view_view(matchList[index])));
                        },
                        child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: EdgeInsets.only(left: 15),
                              child: Container(
                                width: 285,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: commonImage(matchList[index].userAvtar, 120.0, 100.0, "", context, Girls),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 7, left: 5),
                                          child: Text(
                                            getString1(matchList[index].name.toString()),
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 7, left: 5),
                                          child: Text(
                                            "${getString1(matchList[index].age.toString())}yrs | ${getString1(matchList[index].height.toString())}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 7, left: 5),
                                          child: Text(
                                            "${getString1(matchList[index].language.toString())}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.red),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(builder: (context) => DashboardView(2)),
                                                    (route) => false);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(left: 2),
                                                  height: 17,
                                                  width: 25,
                                                  child: Image.asset(chatting),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                      )),
                )
              : Container(
            height: 200,
                child: Center(
                    child: text("No Matches",
                        fontSize: 12.0,
                        fontFamily: fontMedium,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w700)),
              ),
          matchList.length > 0?Container(
            margin: EdgeInsets.only(top: 5),
            child: Divider(
              color: Colors.black,
            ),
          ):SizedBox(),
          matchList.length > 0?InkWell(
            onTap: (){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardView(1)),
                      (route) => false);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "View All",
                style: TextStyle(
                    fontSize: 16, color: Colors.red, fontWeight: FontWeight.w600),
              ),
            ),
          ):SizedBox(),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  String email = "";
  bool showWithdraw = false;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  updateFid(fid) async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "user_id": curUserId.toString(),
        "fuid": fid,
      };
      Map response =
          await apiBase.postAPICall(Uri.parse(baseUrl1 + "updatefuid"), params);
      setState(() {
        loading = false;
      });
      if (response['status'].toString() == "1") {
        //setSnackbar(response['message'], context);
      } else {
       // setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }

  callChat() async {
    await App.init();

    try {
      UserCredential data =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: model!.email.toString(),
        password: "12345678",
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: model!.name.toString(),
          id: data.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=${model!.email.toString()}',
          lastName: "",
        ),
      );
       updateFid( data.user!.uid);
    } catch (e) {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: model!.email.toString(),
        password: "12345678",
      );
      // App.localStorage.setString("firebaseUid", credential.user!.uid);
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: model!.name.toString(),
          id: credential.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=${model!.email.toString()}',
          lastName: "",
        ),
      );
      updateFid(credential.user!.uid);
      print(e.toString());
    }
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          model != null
              ? DrawerHeader(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/Drawer_Couple.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.Profile_screen);
              },
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 60,
                      width: 60,
                      child: commonImage(model!.userAvtar, 60.0, 60.0,
                          "", context, PROFILE),
                    ),
                  ),
                  /*  CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(PROFILE),
                    ),*/
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(8, 10, 00, 00),
                            child: Text(
                              getString1(model!.name.toString()),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              edit_profile_white,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(7, 00, 00, 00),
                        child: Text(
                          getString1(model!.email.toString()),
                            maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Playfair Display',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
              : SizedBox(height: 200,),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 10),
              height: 20,
              width: 20,
              child: Image.asset(
                unselect_home,
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardView(0)),
                      (route) => false);
            },
          ),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 7),
              height: 25,
              width: 25,
              child: Image.asset(
                unselect_cupel,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('Partner Preference'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> partner_preference_details_View()));
              // Get.toNamed(Routes.partner_preference_details);
            },
          ),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 7),
              height: 25,
              width: 25,
              child: Image.asset(
                unselect_star,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('Shortlisted Profile'),
            onTap: () {
              //  Get.toNamed(Routes.Shortlisted_Profile_screen);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Shortlisted_Profile()));
            },
          ),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 7),
              height: 20,
              width: 20,
              child: Image.asset(
                unselect_chat,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('My Requests'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardView(4,chat: false,)),
                      (route) => false);
            },
          ),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 7),
              height: 25,
              width: 20,
              child: Image.asset(
                unselect_heart,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('My Matches'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardView(1)),
                      (route) => false);
            },
          ),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 7),
              height: 25,
              width: 20,
              child: Image.asset(
                unselect_condition,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('Support Pages'),
            onTap: () {
              Get.toNamed(Routes.help_screen);
            },
          ),
          // ListTile(
          //   hoverColor: Colors.red,
          //   dense: true,
          //   leading: Container(
          //     margin: EdgeInsets.only(left: 7),
          //     height: 25,
          //     width: 20,
          //     child: Image.asset(
          //       unselect_condition,
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          //   title: Text('Change Language'),
          //   onTap: () {
          //    // Get.toNamed(Routes.help_screen);
          //   },
          // ),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 7),
              height: 25,
              width: 20,
              child: Image.asset(
                unselect_dayri,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('Privacy Policy'),
            onTap: () {
              //Get.toNamed(Routes.privacy_policy);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyWebView(
                          "https://kumbharreshimgath.com/api/privacyPolicyPage/en",
                          "Privacy Policy")));
            },
          ),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 7),
              height: 25,
              width: 20,
              child: Image.asset(
                unselect_condition,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('Term And Conditions'),
            onTap: () {
              // Get.toNamed(Routes.Term_n_condition);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyWebView(
                          "https://kumbharreshimgath.com/api/termsConditionPage/en",
                          "Term And Conditions")));
            },
          ),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 7),
              height: 25,
              width: 20,
              child: Image.asset(
                unselect_faqs,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('FAQs'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyWebView(
                          "https://kumbharreshimgath.com/api/faqPage/en",
                          "FAQs")));
            },
          ),
          ListTile(
            hoverColor: Colors.red,
            dense: true,
            leading: Container(
              margin: EdgeInsets.only(left: 7),
              height: 25,
              width: 20,
              child: Image.asset(
                unselect_logout,
                fit: BoxFit.contain,
              ),
            ),
            title: Text('Logout'),
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Do You Want to Logout ?"),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text('No'),
                          /*textColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.transparent)),*/
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                            child: Text('Yes'),
                            /* shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.transparent)),
                              textColor: Colors.blue,*/
                            onPressed: () async {
                              await App.init();
                              App.localStorage.clear();
                              model = null;
                              //Common().toast("Logout");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashView()),
                                      (route) => false);
                            }),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
