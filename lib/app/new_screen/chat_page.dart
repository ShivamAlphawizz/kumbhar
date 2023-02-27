import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/list_model.dart';

import 'package:path_provider/path_provider.dart';

class ChatPage extends StatefulWidget {

  UserModel model;
  final types.Room room;
  final fcm;

  ChatPage({required this.model,required this.room, this.fcm});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {



  void _handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

      //await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
    addMessage(message.text.toString());
  //  addNote(widget.fcm, widget.room.users[1].firstName.toString(), message.text.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }
  getDetails(){
    for(int i =0;i<widget.room.users.length;i++){
      print(widget.room.users[i].firstName);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading:
          GestureDetector(
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
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.blue, Colors.pink]),
            ),
          ),
          title:  Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 40,
                  width: 40,
                  child: commonImage(widget.model.userAvtar, 40.0, 40.0, "", context, "assets/profile.png"),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                  child: Text(widget.model.name.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)
              ),
            ],
          ),
        ),
        body: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return StreamBuilder<List<types.Message>>(
                initialData: const [],
                stream: FirebaseChatCore.instance.messages(snapshot.data!),
                builder: (context, snapshot) {
                  return Chat(
                    messages: snapshot.data ?? [],
                    onMessageTap: _handleMessageTap,
                    onPreviewDataFetched: _handlePreviewDataFetched,
                    onSendPressed: _handleSendPressed,
                    user: types.User(
                      id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                    ),
                  );
                },
              );
            }else{
              return Chat(
                messages:  [],
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                user: types.User(
                  id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                ),
              );
            }

          },
        ),
      ),
    );
  }
  bool _isNetworkAvail = true;
  Future<Null> addMessage(body) async {
    await App.init();
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      try {
        var parameter = {"from_user_id": curUserId,  "to_user_id": widget.model.userId,"message":body,"type":"1"};
        print(parameter);
        Response response =
        await post(Uri.parse(baseUrl+"setMessage"), body: parameter, headers: {})
            .timeout(Duration(seconds: timeOut));

        var getdata = json.decode(response.body);
        print(getdata);
      } on TimeoutException catch (_) {
        setSnackbar("Something Wrong",context);
      }
    } else {
      if (mounted)
        setState(() {
          _isNetworkAvail = false;

        });
    }

    return null;
  }
  Future<Null> addNote(fcm,title,body) async {
    await App.init();
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      try {

        var parameter = {"title": title,  "fcm_id": fcm,"body":body};
        print(parameter);
        Response response =
        await post(Uri.parse(""), body: parameter, headers: {})
            .timeout(Duration(seconds: timeOut));

        var getdata = json.decode(response.body);
        print(getdata);
        bool error = getdata["error"];
        String? msg = getdata["message"];

        if (!error) {

        }

      } on TimeoutException catch (_) {
        setSnackbar("Something Wrong",context);
      }
    } else {
      if (mounted)
        setState(() {
          _isNetworkAvail = false;

        });
    }

    return null;
  }
}
