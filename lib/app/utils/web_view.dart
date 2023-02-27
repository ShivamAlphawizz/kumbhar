import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_pro/platform_interface.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/widget.dart';


import 'package:url_launcher/url_launcher.dart';

class MyWebView extends StatefulWidget {
  String url;
  String title;


  MyWebView(this.url, this.title);

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  bool isLoading = true;
   WebViewController? controller;
  Offset position = Offset(20.0, 20.0);
  bool status = false;
   Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  setLoading(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  setController(cont) {
    setState(() {
      controller = cont;
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title: Text(widget.title),
        centerTitle: true,

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xffF72D2D), Color(0xffF5F049)]),
          ),
        ),

        leading: GestureDetector(
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.maxFinite,
          height: height,
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebResourceError: (WebResourceError err) {
                  print("onWebResourceError----------------${err}");
                },
                onWebViewCreated: (c) {
                  setController(c);
                },
                onPageFinished: (url1) async {
                  setLoading(false);
                },
                onPageStarted: (url1) async {

                },
              ),
              isLoading
                  ? Center(
                      child: Container(
                        color: Colors.blueGrey,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child:  Center(
                            child: loadingWidget(
                          color: Colors.red,
                        )),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }


}
