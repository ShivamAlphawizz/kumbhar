import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/Home/views/Home_view.dart';
import 'package:indianmilan/app/modules/Notification/views/Notification_view.dart';
import 'package:indianmilan/app/modules/Prime_membership/views/Prime_membership_view.dart';
import 'package:indianmilan/app/new_screen/chat_screen.dart';
import 'package:indianmilan/app/new_screen/matches_screen.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/location_details.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart' as http;
import '../../../utils/image_helper.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  int index;
  bool chat;

  DashboardView(this.index,{this.chat = true});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;
  DateTime? currentBackPressTime;
  List<String> titleList = ["Home","My Matches","My Chats","Premium Membership","My Requests"];
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if(widget.chat){
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        setSnackbar("Press back again to exit",context);
        return Future.value(false);
      }
      exit(1);
    }else{
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardView(0)),
              (route) => false);

    }
   return Future.value();
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


    });
    location.getLoc();
    _currentIndex = widget.index;
   // updateLatLng();
  }
  updateLatLng() async {
    Map param = {};
    param['user_id'] = curUserId;
    param['lat'] = latitude.toString();
    param['lang'] = longitude.toString();
    print(param);
    var res =
    await http.post(Uri.parse(baseUrl + "update_profile"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);

    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {

    } else {}

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: TextFieldShow(
              color: Colors.white,
              text: _currentIndex==0?address:titleList[_currentIndex],
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
                    colors: <Color>[Color(0xffF72D2D), Color(0xffF5F049)]),
              ),
            ),
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Notifications_View()));
                  //  Get.toNamed(Routes.Notofication_screen);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        drawer: MyDrawer(),
        // backgroundColor: Theme.of(context).primaryColor,
          bottomNavigationBar: widget.chat?Padding(
            padding: const EdgeInsets.all(0.0),
            child: ClipRRect(
              // borderRadius: BorderRadius.all(Radius.circular(10)),
              child: BottomNavigationBar(
                elevation: 10,
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xffffffff),
                selectedItemColor: Color(0xffF72D2D),
                unselectedItemColor: Colors.black.withOpacity(.60),
                selectedFontSize: 11,
                unselectedFontSize: 11,
                onTap: (value) {
                  setState(() {
                    _currentIndex = value;
                  });

                  // Respond to item press.
                },
                items: [

                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(Icons.home),
                  ),

                  BottomNavigationBarItem(
                    label: "Matches",
                    icon: Icon(Icons.heart_broken),
                  ),

                  BottomNavigationBarItem(
                    label: "Chat",
                    icon: Icon(Icons.chat_rounded),
                  ),

                  BottomNavigationBarItem(
                    label: "Premium",
                    icon: Icon(Icons.star),
                  ),

                  /*BottomNavigationBarItem(
                      label: "Settings",
                      icon: Icon(Icons.settings),
                    ),*/
                ],
              ),
            ),
          ):SizedBox(),
          body: buildScreens[_currentIndex]
      ),
    );
  }

  /*AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person_outline,
            color: Colors.black,
          ),
        ),
      ],
      title: Center(
        child:  Image(
          image: AssetImage(Side_Menu),
          width: 100,
          height: 50,
        ),
      ),
    );
  }*/

  List buildScreens = <Widget>[
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
    Screen5(),
    /* Screen5(),*/
  ];
}

List<PersistentBottomNavBarItem> navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      contentPadding: 5,
      title: "\n Home",
      textStyle: TextStyle(
        fontSize: 14,
        fontFamily: 'Lato',
      ),
      activeColorPrimary: Color(0xffF72D2D),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      contentPadding: 5,
      icon: Icon(Icons.add),
      title: ("Girls"),
      textStyle: TextStyle(
        fontSize: 14,
        fontFamily: 'Lato',
      ),
      activeColorPrimary: Color(0xffF72D2D),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.calendar_today_outlined),
      title: ("\n Create Event"),
      textStyle: TextStyle(
        fontSize: 14,
        fontFamily: 'Lato',
      ),
      activeColorPrimary: Color(0xffF72D2D),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.help_outline),
      contentPadding: 5,
      title: ("\n FAQ"),
      textStyle: TextStyle(
        fontSize: 14,
        fontFamily: 'Lato',
      ),
      activeColorPrimary: Color(0xffF72D2D),
      inactiveColorPrimary: Colors.grey,
    ),
    /*PersistentBottomNavBarItem(
      icon: Icon(Icons.settings),
      contentPadding: 5,
      title: ("\n Profile"),
      textStyle: TextStyle(
        fontSize: 14,
        fontFamily: 'Lato',
      ),
      activeColorPrimary: Color(0xffEC297B),
      inactiveColorPrimary: Colors.grey,
    ),*/
  ];
}

Widget Screen1() {
  return Home_view();
}

Widget Screen2() {
  return MyMatches();
}

Widget Screen3() {
  return ChatScreen(true);
}
Widget Screen5() {
  return ChatScreen(false);
}

Widget Screen4() {
  return Premium_Membership_view();
}

