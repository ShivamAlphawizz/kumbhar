import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';



class faqs_Profile extends StatefulWidget {
  const faqs_Profile({Key? key}) : super(key: key);

  @override
  State<faqs_Profile> createState() => _faqs_ProfileState();
}

class _faqs_ProfileState extends State<faqs_Profile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faq's"),
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

        leading:  GestureDetector(
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
      body: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(top: 5),

          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) =>

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                  child: ExpansionTileCard(
                    baseColor: Colors.grey[100],
                    expandedColor: Colors.grey[300],
                    trailing: Container(
                      height: 25,width: 25,
                      child: Image.asset(Pluse_Button),
                    ),
                    elevation: 10,
                    // key: cardA,
                    // leading: CircleAvatar(child: Text('A')),
                    title: Text("How can i update my profile",style: TextStyle(fontWeight: FontWeight.w600),),
                    // subtitle: Text('I expand!'),
                    children: <Widget>[
                      Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.",textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          )


      ),
    );
  }

}


