import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/My_profile_details/views/profile_view.dart';
import 'package:indianmilan/app/modules/Shortlisted_Profile/controllers/Shortlisted_Profile_controller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/model/list_model.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/widget.dart';
class Shortlisted_Profile extends StatefulWidget {
  const Shortlisted_Profile({Key? key}) : super(key: key);

  @override
  _Shortlisted_ProfileState createState() => _Shortlisted_ProfileState();
}

class _Shortlisted_ProfileState extends State<Shortlisted_Profile> {


  List<UserModel> shortList = [];
  bool loading = true;
  getShort() async{
    Map param =  {};
    param['user_id']= curUserId;
    print(param);
    var res = await http.post(Uri.parse(baseUrl+"getShortlist"),body: param,headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      loading = false;
    });
    setSnackbar(response['message'].toString(), context);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          shortList.add(new UserModel.fromJson(v));
        });

      }
    }else{

    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShort();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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




          title: TextFieldShow(
            color: Colors.white,
            text: SHORTLISTED,
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
                onTap:() {
                  Get.toNamed(Routes.Notofication_screen);
                },

                child:  Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Icon(Icons.notifications_none_outlined,color: Colors.white,),
                )

            ),
          ],
        ),
        body: !loading?shortList.length>0?ListView(
          children: <Widget>[
            Container(
              height: 20,
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "${shortList.length} Shortlisted Profile",
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            Container(
              margin: EdgeInsets.only( top: 10, bottom: 10),
              height: MediaQuery.of(context).size.height/1.2,
              child: ListView.builder(
                  itemCount: shortList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context,int index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>profile_view_view(shortList[index])));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        margin: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                        elevation: 10,
                        color: Colors.white,
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child:Card(
                                    elevation: 0,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: commonImage(shortList[index].userAvtar, 100.0, 100.0, "", context, Girls),
                                    ),
                                  )
                              ),

                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 15, top: 10, right: 5, bottom: 3),
                                      child: Text(getString1(shortList[index].name.toString()), textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15, top: 2, right: 5, bottom: 3),
                                      child: Text("${shortList[index].age} Yrs | ${shortList[index].height} " , textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15, top: 2, right: 5, bottom: 3),
                                      child: Text("${(getString1(shortList[index].language.toString()))}" , textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15, top: 2, right: 5, bottom: 3),
                                      child: Text("${(getString1(shortList[index].occupation.toString()))}" , textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15, top: 2, right: 5, bottom: 3),
                                      child: Text("${(getString1(shortList[index].income.toString()))}" , textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),),
                                    ),
                                  /*  Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.orange),
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      padding: EdgeInsets.only(left: 15, top: 2, right: 5, bottom: 3),
                                      child: Text("Connect Now" , textAlign: TextAlign.justify,style: GoogleFonts.roboto(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),),
                                    ),*/

                                  ],
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
                    );

                  }
              ),
            ),

          ],
        )
            :
        Container(
            height: 100.h,
            child: Center(child: text("No Shorted",fontSize: 12.sp,fontFamily: fontMedium,textColor: Colors.black,fontWeight: FontWeight.w700))):Center(child: loadingWidget(),),
      );

  }
}



