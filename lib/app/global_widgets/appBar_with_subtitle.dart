import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appbarSubTITLE(String title, String sub_title, Function onTap) =>
    AppBar(

      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),

      elevation: 2,
      leadingWidth: 30,
      backgroundColor: Color(0xff0D0B21),
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
              size: 16,
            ),
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          // GestureDetector(
          //   onTap: () {
          //     onTap();
          //   },
          //   child: Text(
          //     sub_title,
          //     style: TextStyle(color: Colors.pink, fontSize: 16),
          //   ),
          // ),
        ],
      ),
    );

/*


title: Text("Shortlisted Profile"),
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
Container(
margin: EdgeInsets.only(right: 12),
child: Icon(Icons.notifications_none_outlined,color: Colors.white,),
)
],


leading:
GestureDetector(
onTap: () {
Get.back();
},
child:  Container(
height: 50,
width: 50,
child: Image.asset(BACK_BUTTON),
),
),
*/
