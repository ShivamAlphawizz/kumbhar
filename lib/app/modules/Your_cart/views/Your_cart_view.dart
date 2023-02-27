
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/utils/ApiBaseHelper.dart';
import 'package:indianmilan/app/utils/Razorpay.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/package_model.dart';

import '../../../routes/app_pages.dart';

class Your_cart_view extends StatefulWidget {
  PackageModel model;


  Your_cart_view(this.model);

  @override
  _Your_cart_view_State createState() => _Your_cart_view_State();
}

class _Your_cart_view_State extends State<Your_cart_view> {



  TextEditingController _serch = new TextEditingController();

  String dropdownvalue = 'Min.Age';

  var items = [
    'Min.Age',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Membership Details"),
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

        // leading:Container(
        //   child: Image.asset("images/backicon_indianmilan.png"),
        // ),




      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/5,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                InkWell(
                  onTap: (){
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 100,
                      width: 100,
                      child: commonImage(model!.userAvtar, 100.0, 100.0, "", context, PROFILE),
                    ),
                  ),
                ),
                // CircleAvatar(
                //   foregroundColor: Colors.white,
                //
                //    radius: 35,
                //   backgroundImage: AssetImage('images/profileimage.png'),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(getString1(model!.name.toString()), style:TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
                )
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),),

            margin: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
            elevation: 15,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 3),
                          child: Row(
                            children: [
                              Text(widget.model.title.toString(), textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                              Text("  Rs ${widget.model.price.toString()}", textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),),

                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 3),
                          child: Text(
                            historyModel==null||widget.model.packagesId!=historyModel!.packagesId?"Duration ${widget.model.noOfDays.toString()} days":"Expiry On ${historyModel!.endSubscriptionDate}",
                            textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 3),
                          child: Text(widget.model.description.toString(), textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child:Image.asset(king),
                      ),
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(right: 5),
                  //   child: Icon(Icons.delete_outline_sharp,color: ColorValues.BUTTONBACKGROUND,),
                  // )

                ],
              ),
            ),
          ),
          historyModel==null||widget.model.packagesId!=historyModel!.packagesId?InkWell(
            onTap: (){
              RazorPayHelper razorPay = new RazorPayHelper(widget.model.price.toString(), context, (result){
                if(result!="error"){
                  addSubscription(result);
                }else{
                  setState(() {
                    loading = false;
                  });
                }
              });
              setState(() {
                loading = true;
              });
              razorPay.init();
            },
            child: Container(
              margin: EdgeInsets.only(top: 30, left: 30, right: 30),
              height: MediaQuery.of(context).size.height/15,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.blue, Colors.lightBlue]),
                  borderRadius: BorderRadius.circular(30)
              ),
              alignment: Alignment.center,
              child:!loading?Text("Pay Now", style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15)):loadingWidget(color: Colors.white,),
            ),
          ):SizedBox()
        ],
      ),

    );
  }
  bool loading = false;
  bool showWithdraw = false;
  ApiBaseHelper apiBase = new ApiBaseHelper();


  addSubscription(orderId) async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "user_id": curUserId.toString(),
        "price": widget.model.price.toString(),
        "txn_id": orderId.toString(),
        "order_id": orderId.toString(),
        "packages_id":widget.model.packagesId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "userSubscribe"), params);
      setState(() {
        loading = false;
      });
      if (response['status'].toString()=="1") {
        setSnackbar(response['message'], context);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);

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
