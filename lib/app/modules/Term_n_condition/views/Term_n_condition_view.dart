import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/modules/Login/views/login_view.dart';
import 'package:indianmilan/app/modules/Term_n_condition/controllers/Term_n_condition_controller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';


class Term_n_condition_view extends GetView<Term_n_condition_controller> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Term and Condition"),
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

      body: ListView(
        children: [

          Container(
            margin: EdgeInsets.only(top: 30,left: 15),
            child: Text("Our Privacy Policy",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
          ),

          Container(
            margin: EdgeInsets.only(left: 15,right: 15,top: 10),
            child: Text("Lorem Ipsum is simply dumm y text of the printing and typesetting industry."
                " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
                " when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                " It has survived not only five centuries, but also the leap into electronic typesetting,"
                " remaining essentially unchanged. It was popularised in the 1960s with the release of "
                "Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software "
                "like Aldus PageMaker including versions of Lorem Ipsum."
                "like Aldus PageMaker including versions of Lorem Ipsum."
                "Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software"
                "Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software"

              ,

              textAlign: TextAlign.justify,),
          )

        ],
      ),
    );
  }

}


