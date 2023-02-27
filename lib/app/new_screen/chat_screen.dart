import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/new_screen/chat_page.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/ApiBaseHelper.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/model/list_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  bool chat;
  ChatScreen(this.chat);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<UserModel> userList = [];
  List<UserModel> connectList = [];
  bool loading = true;
  getUser() async {
    Map param = {};
    param['user_id'] = curUserId;
    //  param['type']= "0";
    print(param);
    var res = await http
        .post(Uri.parse(baseUrl + "get_accept_request"), body: param, headers: {
      "Accept-Language": langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      userList.clear();
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        if (v['mystatus'] != "0") {
          setState(() {
            userList.add(new UserModel.fromJson(v));
          });
        } else {}
      }
    } else {}
  }

  getConnect() async {
    Map param = {};
    param['user_id'] = curUserId;
    param['type'] = "1";
    print(param);
    print("kkkkkkkkk ${baseUrl}getInterest    and ${param}");
    var res = await http
        .post(Uri.parse(baseUrl + "getInterest"), body: param, headers: {
      "Accept-Language": langCode,
    });

    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      connectList.clear();
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if (response['status'].toString() == "1") {
      for (var v in response['data']) {
        if (v['mystatus'] == "0") {
          setState(() {
            connectList.add(new UserModel.fromJson(v));
          });
        } else {
          /* setState(() {
            userList.add(new UserModel.fromJson(v));
          });*/
        }
      }
    } else {}
  }

  bool showWithdraw = false;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  addStatus(id, status) async {
    try {
      setState(() {
        showWithdraw = true;
      });
      Map params = {
        "user_id": curUserId.toString(),
        "requested_id": id.toString(),
        "status": status.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "acceptedInterest"), params);
      setState(() {
        showWithdraw = false;
      });
      if (response['status'].toString() == "1") {
        setSnackbar(response['message'], context);
        getUser();
        getConnect();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.chat) {
      getUser();
    } else {
      getConnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
       leading:
        GestureDetector(
          onTap:(){
            Get.back();
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

        title:
        //Text(),
        TextFieldShow(
          color: Colors.white,
          text: "Chat",
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
              onTap:() {
                Get.toNamed(Routes.Notofication_screen);
              },

              child:  Container(
                margin: EdgeInsets.only(right: 12),
                child: Icon(Icons.notifications_none_outlined,color: Colors.white,),
              )

          ),
        ],
      ),*/
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !widget.chat
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      text("Connection Request",
                          fontSize: 16.0,
                          fontFamily: fontMedium,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 10,
                      ),
                      !loading
                          ? connectList.length > 0
                              ? Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: connectList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Card(
                                                        elevation: 5,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Container(
                                                            height: 60,
                                                            width: 60,
                                                            decoration:
                                                                boxDecoration(
                                                                    showShadow:
                                                                        true,
                                                                    radius:
                                                                        100.0),
                                                            child: commonImage(
                                                                connectList[
                                                                        index]
                                                                    .userAvtar,
                                                                70.0,
                                                                70.0,
                                                                "",
                                                                context,
                                                                PROFILE),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          child: Text(
                                                        connectList[index]
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                    ],
                                                  ),
                                                  !showWithdraw
                                                      ? Row(
                                                          children: [
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons.clear,
                                                              ),
                                                              onPressed: () {
                                                                addStatus(
                                                                    connectList[
                                                                            index]
                                                                        .userId,
                                                                    "2");
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons.check,
                                                              ),
                                                              onPressed: () {
                                                                addStatus(
                                                                    connectList[
                                                                            index]
                                                                        .userId,
                                                                    "1");
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                      : loadingWidget(),
                                                ],
                                              ),
                                              Divider(),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              : Container(
                                  height: getHeight(800),
                                  child: Center(
                                      child: text("No Request",
                                          fontSize: 14.sp,
                                          fontFamily: fontMedium,
                                          textColor: Colors.black,
                                          fontWeight: FontWeight.w700)))
                          : Container(
                        height: getHeight(800),
                            child: Center(
                                child: loadingWidget(),
                              ),
                          ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      text("Recent Chats",
                          fontSize: 16.0,
                          fontFamily: fontMedium,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 10,
                      ),
                      !loading
                          ? userList.length > 0
                              ? Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: userList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              chatLoading = true;
                                            });
                                            callChat(userList[index]);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Card(
                                                          elevation: 5,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child: Container(
                                                              height: 60,
                                                              width: 60,
                                                              decoration:
                                                                  boxDecoration(
                                                                      showShadow:
                                                                          true,
                                                                      radius:
                                                                          100.0),
                                                              child: commonImage(
                                                                  userList[
                                                                          index]
                                                                      .userAvtar,
                                                                  60.0,
                                                                  60.0,
                                                                  "",
                                                                  context,
                                                                  PROFILE),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                            child: Text(
                                                          userList[index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                      ],
                                                    ),
                                                    chatLoading
                                                        ? loadingWidget()
                                                        : SizedBox(),
                                                  ],
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              : Container(
                        height: getHeight(800),
                                child: Center(
                                    child: text("No Chats",
                                        fontSize: 14.sp,
                                        fontFamily: fontMedium,
                                        textColor: Colors.black,
                                        fontWeight: FontWeight.w700)),
                              )
                          : Container(
                        height: getHeight(800),
                            child: Center(
                                child: loadingWidget(),
                              ),
                          ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  bool chatLoading = false;
  callChat(UserModel model) async {
    print("chekcing model here ${model} and ${model.userId}");
    await App.init();
    print("fuid" + model.fuid.toString());
    var otherUser1 = types.User(
      firstName: model.name,
      id: model.userId.toString(),
      imageUrl: 'https://i.pravatar.cc/300?u=${model.email}',
      lastName: "",
    );
    print("other user 1 here ${otherUser1.id} and ${otherUser1.imageUrl} and ${otherUser1.firstName} and ${otherUser1.role}");
    _handlePressed(otherUser1, context, model.deviceToken.toString(), model);
  }

  _handlePressed(types.User otherUser, BuildContext context, String fcmID,
      UserModel model) async {
    print("handle pressed data here ${otherUser} and ${fcmID} and ${model}");
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    setState(() {
      chatLoading = false;
    });
    print("sdsdsd ${room}");
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
          fcm: fcmID,
          model: model,
        ),
      ),
    );
  }
}
