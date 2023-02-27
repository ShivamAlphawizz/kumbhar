import 'dart:convert';

import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/Prime_membership/controllers/Prime_membership_controller.dart';
import 'package:indianmilan/app/modules/Your_cart/views/Your_cart_view.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/package_model.dart';
class Premium_Membership_view extends StatefulWidget {
  const Premium_Membership_view({Key? key}) : super(key: key);

  @override
  _Premium_Membership_viewState createState() => _Premium_Membership_viewState();
}

class _Premium_Membership_viewState extends State<Premium_Membership_view> {
  List <String> Images = [
    'Image_Shortlist_prifile/Group 55996.png',
    'Image_Shortlist_prifile/Group 55997.png',
    'Image_Shortlist_prifile/Group 55998 154.png',
  ];

  List <String> price=[
    "RS- 2399",
    "Rs- 1500",
    "Free"
  ];


  List <String> Time=[
    "( 1 Year )",
    "( 6 Months )",
    ""
  ];
  List<PackageModel> packageList = [];
  bool loading = true;

  getPackage() async{
    Map param =  {};
    param['user_id']= curUserId;
    print(param);
    var res = await http.post(Uri.parse(baseUrl+"get_package"),body: param,headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loading = false;
    });
  //  setSnackbar(response['message'].toString(), context);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          packageList.add(new PackageModel.fromJson(v));
        });

      }
    }else{

    }

  }

  getHistory() async{
    Map param =  {};
    param['user_id']= curUserId;
    print(param);
    var res = await http.post(Uri.parse(baseUrl+"subscribeHistory"),body: param,headers: {
      "Accept-Language" : langCode,
    });
    print(res.body);
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        /* setState(() {
          packageList.add(new PackageModel.fromJson(v));
        });*/

      }
    }else{
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPackage();
    //getHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      /*appBar: AppBar(
        leading: SizedBox(),
       *//* leading:
        GestureDetector(
          onTap:(){
            Get.back();
          },
          child:  Container(
            margin: EdgeInsets.only(left: 10),
            height: 60,
            width: 60,
            child: Image.asset(
              BACK_BUTTON,
              fit: BoxFit.cover,
            ),

          ),
        ),*//*

        title:
        //Text(),
        TextFieldShow(
          color: Colors.white,
          text: "Premium Membership",
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
          Container(
            margin: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_none_outlined,color: Colors.white,),
          )
        ],
      ),*/
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only( top: 00, bottom: 5),
          child: !loading?packageList.length>0?Column(
            children: [
              SizedBox(height: 10,),
              text("Current Plan Details",fontSize: 12.0,fontFamily: fontMedium,textColor: Colors.black,fontWeight: FontWeight.w700),
              SizedBox(height: 10,),
               historyModel!=null?GestureDetector(
            onTap: (){
              int i = packageList.indexWhere((element) => element.packagesId==historyModel!.packagesId.toString());
              if(i!=-1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Your_cart_view(packageList[i])));
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
              elevation: 15,
              child: Container(
                padding: EdgeInsets.only(bottom: 12,left: 5,right: 5),
               // height: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage("assets/premuim.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child:Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 5, left: 5),
                            child: Image.asset("assets/crown0.png"),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 0   ),
                            child: Text(historyModel!.subscriptionTitle.toString(), textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 15, top: 2, right: 5, bottom: 0),
                            child: Text("Rs. "+historyModel!.price.toString(), textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),),
                          ),
                          // Container(
                          //   padding: EdgeInsets.only(left: 15, top: 0, right: 5, bottom: 3),
                          //   child: Text("Expiry On "+historyModel!.subscriptionEndDate.toString(),style: GoogleFonts.roboto(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 12),),
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 15,
                                width: 15,
                                child: Image.asset(check),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5,right: 20),
                                  child: Text(historyModel!.subscriptionName.toString(), textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),maxLines: 2,),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text("Expiry On "+historyModel!.subscriptionEndDate.toString(),style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ):
               text("No Plan",fontSize: 12.0,fontFamily: fontMedium,textColor: Colors.black,fontWeight: FontWeight.w700),
              SizedBox(height: 10,),
              text("All Plan Details",fontSize: 12.0,fontFamily: fontMedium,textColor: Colors.black,fontWeight: FontWeight.w700),
              SizedBox(height: 10,),
              ListView.builder(
                shrinkWrap: true,
                  itemCount: packageList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context,int index) {
                    return GestureDetector(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Your_cart_view(packageList[index])));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.transparent,
                        margin: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                        elevation: 15,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 12,left: 5,right: 5),
                        //  height: MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage("assets/premuim.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child:Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.only(top: 5, left: 5),
                                      child: Image.asset("assets/crown${index%3}.png")
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 3),
                                      child: Text(packageList[index].title.toString(), textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 3),
                                      child: Text("Rs. "+packageList[index].price.toString(), textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                          color: Colors.orangeAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),),
                                    ),
                                    // Container(
                                    //   alignment: Alignment.topLeft,
                                    //   padding: EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 3),
                                    //   child: Text(packageList[index].noOfDays.toString()+" Days", textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                    //       color: Colors.white,
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 14),),
                                    // ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          height: 15,
                                          width: 15,
                                          child: Image.asset(check),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 3),
                                            child: Text(packageList[index].description.toString(), textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 9),),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 35, top: 5, right: 5, bottom: 3),
                                      child: Text(packageList[index].noOfDays.toString()+" Days", textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );

                  }
              ),
            ],
          ):Container(
              height: getHeight(900),
              child: Center(child: Text("No Subscription"),)):Container(
              height: getHeight(900),
              child: Center(child: loadingWidget(),)),
        ),
      ),

    );
  }

}



