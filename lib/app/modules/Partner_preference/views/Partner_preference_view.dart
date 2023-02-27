import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/modules/Partner_preference/controllers/Partner_preference_cotroller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:indianmilan/app/utils/toast.dart';


class Partner_preference_view extends GetView<Partner_preference_Controller> {

  bool toggle = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;





  Widget getTitle() {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      height: 40,
      width: 120,
      child: Image.asset(
        SPLASH_IMAGE,
        fit: BoxFit.fill,
      ),
    );
  }

  Container getBackButton() {
    return Container(
      padding: EdgeInsets.all(getWidth(20)),
      height: getHeight(50),
      width: getHeight(50),
      child: Image.asset(
        BACK_BUTTON,
        fit: BoxFit.fill,
      ),
    );
  }

  Row getHeader() {
    return  Row(
      children: <Widget>[
        GestureDetector(
          onTap:(){
            Get.back();
          },
          child: getBackButton(),
        ),
        const Spacer(
          //flex: 1,
        ),
        getTitle(),
        const Spacer(flex: 2)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    // bool isScreenWide = MediaQuery.of(context).size.width >= kMinWidthOfLargeScreen;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    beginWidth = Dimension.max(20.toPercentLength, 700.toPXLength);
    beginHeight = (90.toVHLength - 10.toPXLength);

    endWidth = Dimension.clamp(200.toPXLength, 40.toVWLength, 200.toPXLength);
    endHeight = 50.toVHLength +
        10.toPercentLength -
        Dimension.min(4.toPercentLength, 40.toPXLength);

    //LocalNotificationService.initialize(context);
    return
      Scaffold(
          backgroundColor: Colors.white,
          body:
          SingleChildScrollView(
            child:  Column(children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child:
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height:  350.toPercentLength.value,
                            child: Image.asset(
                              LOGIN_BACKGRAUND,
                              fit: BoxFit.fill,
                            ),
                          ),

                        ],)

                  ),


                  Column(
                    children: <Widget>[

                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, statusBarHeight, 0.0, 0.0),
                            child: Column(
                              children: <Widget>[getHeader()],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            // padding: EdgeInsets.fromLTRB(20,5,20,5),
                            child: TextFieldShow(
                              color: Colors.white,
                              text: Partner_Preference,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              fontsize: 14,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(00,0,30,0),
                                child: TextFieldShow(
                                  color: Colors.orangeAccent,
                                  text: Skip_For_Leter,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500,
                                  fontsize: 12,
                                ),
                              ),
                            ],),
                        ],),

                      Padding(
                        padding: EdgeInsets.only(top: 10,right: 30,left: 30,bottom: 20),
                        child: Card(
                          elevation: 10,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextFieldShow(
                                  color: Colors.orangeAccent,
                                  text: mandatory,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500,
                                  fontsize: 14,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                            ],),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10,right: 30,left: 30,bottom: 20),
                        child: Card(
                          elevation: 10,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextFieldShow(
                                  color: Colors.orangeAccent,
                                  text: Religious_prefrence,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500,
                                  fontsize: 14,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                            ],),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10,right: 30,left: 30,bottom: 20),
                        child: Card(
                          elevation: 10,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextFieldShow(
                                  color: Colors.orangeAccent,
                                  text: Professional_prefrence,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500,
                                  fontsize: 14,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                            ],),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10,right: 30,left: 30,bottom: 20),
                        child: Card(
                          elevation: 10,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextFieldShow(
                                  color: Colors.orangeAccent,
                                  text: Location_prefrence,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500,
                                  fontsize: 14,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: MediaQuery.of(context).size.height * 0.03),
                                  child:  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Select Topic",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Lato',
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: controller.items_party_type
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                          .toList(),
                                      value: controller.selectedValue,
                                      onChanged: (value) {
                                        Toast.show(value.toString());
                                        // setState(() {
                                        //
                                        // });
                                        controller.selectedValue = value as String;
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      iconOnClick: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                      buttonHeight: 50,
                                      buttonWidth: double.infinity,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding:
                                      EdgeInsets.only(left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xffc5c4c7),
                                          //36325A
                                        ),
                                        color: Colors.white,
                                        //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                                      ),
                                      //buttonElevation: 2,
                                      itemHeight: 40,
                                      itemPadding: EdgeInsets.only(left: 10, right: 10),
                                      dropdownMaxHeight: 200,
                                      //   dropdownWidth: 350,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        //color: Color(0xff211D4A),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius: const Radius.circular(40),
                                      scrollbarThickness: 5,
                                      scrollbarAlwaysShow: true,
                                      /*offset: const Offset(20, 0),*/
                                    ),
                                  )
                              ),
                            ],),
                        ),
                      ),

                      Container(
                        //padding: const EdgeInsets.fromLTRB(00,00,00,00),
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30,20,30,20),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 00),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[Colors.blue, Colors.lightBlue]),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFieldShow(
                              color: Colors.white,
                              text: Continue,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              fontsize: 20,
                            ),
                          ),
                          onTap: () async {
                            Get.toNamed(Routes.Deshboard_view_screen);
                          },
                        ),
                      ),





                    ],)




                ],
              )

            ],),
          )
      );
  }


}
