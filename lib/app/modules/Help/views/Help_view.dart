import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';


class help extends GetView<GetxController> {

  TextEditingController _serch = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Help & Support",),

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




      ),

      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: 15, top: 10, bottom: 10, right: 15),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100]
            ),
            child: TextField(
              onSubmitted: (String value) async {
                // setState(() {
                //
                // });

              },
              controller: _serch,
              autofocus: false,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Search Your Problem',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintStyle: TextStyle(color: Colors.black,fontSize: 14),
                filled: true,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 15,right: 15,top: 5),
            child: Image.asset(help_card_image),
          ),

          Container(
            margin: EdgeInsets.only(top: 15,left: 15,right: 15),

            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: PageScrollPhysics(),
              childAspectRatio: 0.90,
              children: List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.only( bottom:10),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Card(
                      color: Colors.red[50],
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Container(
                        // width: MediaQuery.of(context).size.width / 3,
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 50,
                              width: 75,
                              child: Image.asset(
                                Faq_red,
                                fit: BoxFit.fill,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 7),
                              alignment: Alignment.center,
                              child: Text(
                                "Community",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              ),
            ),

          ),

          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.topCenter,
            child: Text("Getting Started",style: TextStyle(color: Colors.red,fontSize: 17,fontWeight: FontWeight.w600),),
          ),

          Container(
            margin: EdgeInsets.only(top: 10,left: 25,right: 25),
            alignment: Alignment.topCenter,
            child: Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock,",textAlign: TextAlign.justify,),
          ),

          Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(top: 5),

              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) =>

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                      child: ExpansionTileCard(
                        baseColor: Colors.red[50],
                        expandedColor: Colors.red[100],
                        // trailing: Container(
                        //   height: 25,width: 25,
                        //   child: Image.asset("images/faqaddbutton.png"),
                        // ),
                        elevation: 10,
                        // key: cardA,
                        // leading: CircleAvatar(child: Text('A')),
                        title: Text("My Profile Missing",style: TextStyle(fontWeight: FontWeight.w600),),
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

          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.topCenter,
            child: Text("Community",style: TextStyle(color: Colors.red,fontSize: 17,fontWeight: FontWeight.w600),),
          ),

          Container(
            margin: EdgeInsets.only(top: 10,left: 25,right: 25),
            alignment: Alignment.topCenter,
            child: Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock,",textAlign: TextAlign.justify,),
          ),

          Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(top: 5),

              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) =>

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                      child: ExpansionTileCard(
                        baseColor: Colors.red[50],
                        expandedColor: Colors.red[100],
                        // trailing: Container(
                        //   height: 25,width: 25,
                        //   child: Image.asset("images/faqaddbutton.png"),
                        // ),
                        elevation: 10,
                        // key: cardA,
                        // leading: CircleAvatar(child: Text('A')),
                        title: Text("My Profile Missing",style: TextStyle(fontWeight: FontWeight.w600),),
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

          Container(
            margin: EdgeInsets.only(left: 15,right: 15,top: 25,bottom: 20),
            child: Card(
              child: Container(
                height: 80,
                color: Colors.red[50],

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 15),
                          child: Text("Business Support",style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Text("Business@milan.com",style: TextStyle(fontWeight: FontWeight.w300),),
                        ),
                      ],

                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20,top: 15),
                          child: Text("General Support",style: TextStyle(fontWeight: FontWeight.w600),),
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 20,top: 10),
                          child: Text("General@milan.com",style: TextStyle(fontWeight: FontWeight.w300),),
                        ),

                      ],

                    )
                  ],
                ),

              ),
            ),
          ),






        ],
      ),

    );
  }
}

