import 'dart:convert';

import 'package:dimension/dimension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/global_widgets/textEnter.dart';
import 'package:indianmilan/app/global_widgets/textfield_ui.dart';
import 'package:indianmilan/app/modules/Login/controllers/login.dart';
import 'package:indianmilan/app/modules/Register/controllers/Register_cotroller.dart';
import 'package:indianmilan/app/modules/Register_three/views/Register_three_view.dart';
import 'package:indianmilan/app/modules/Register_two/controllers/Register_two_cotroller.dart';
import 'package:indianmilan/app/modules/login_type/controllers/login_type_controller.dart';
import 'package:indianmilan/app/modules/splash/controllers/splash_controller.dart';
import 'package:indianmilan/app/routes/app_pages.dart';
import 'package:indianmilan/app/utils/Session.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/string_helper.dart';
import 'package:indianmilan/app/utils/toast.dart';
import 'package:http/http.dart' as http;
import 'package:indianmilan/app/utils/widget.dart';
import 'package:indianmilan/model/register_model.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:textfield_search/textfield_search.dart';

class Register_two_view extends StatefulWidget {
  var param;


  Register_two_view(this.param);

  @override
  _Register_two_viewState createState() => _Register_two_viewState();
}

class _Register_two_viewState extends State<Register_two_view> {
  bool toggle = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;
  Map param={};
  DateTime startDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2002,12,31),

        firstDate: DateTime(1900),
        lastDate: DateTime(2002,12,31));
    if (picked != null) {
      setState(() {
        startDate = picked;
        dobCon.text = DateFormat("dd-MM-yyyy").format(startDate);
      });
    }
  }
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        birthCon.text = picked.hour.toString() + ":"+picked.minute.toString();
      });
    }
  }

  TextEditingController myController = TextEditingController();
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
            Get.toNamed(Routes.REGISTER);
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
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(model!=null){
      if(model!.email!=null&&model!.email!=""){
        emailCon.text = model!.email.toString();
      }
      if(model!.mobile!=null&&model!.mobile!=""){
        mobileCon.text = model!.mobile.toString();
      }
      if(model!.birthPlace!=null&&model!.birthPlace!=""){
        placeCon.text = model!.birthPlace.toString();
      }
      if(model!.birthTime!=null&&model!.birthTime!=""){
        birthCon.text = model!.birthTime.toString();
      }
     /* if(model!.password!=null&&model!.password!=""){
        passCon.text = model!.password.toString();
      }*/
      if(model!.dob!=null&&model!.dob!=""){
        dobCon.text = model!.dob.toString();
      }
      /*if(model!.country!=null&&model!.country!=""&&model!.country!="0"){
        conId = model!.country.toString();
      }*/
    }

    getData();
    param = widget.param;
  }
  TextEditingController emailCon = new TextEditingController();
  TextEditingController mobileCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();
  TextEditingController dobCon = new TextEditingController();
  TextEditingController birthCon = new TextEditingController();
  TextEditingController placeCon = new TextEditingController();
  String? conId;
  List<CountryModel> conList = [];
  getData()async{
    var res = await http.get(Uri.parse(baseUrl+"getcounntry"),headers: {
      "Accept-Language" : langCode,
    });
    Map response = jsonDecode(res.body);
    print(response);
    if(response['status'].toString()=="1"){
      for(var v in response['data']){
        setState(() {
          conList.add(new CountryModel.fromJson(v));
          if(model!=null){
            if(model!.country.toString().toLowerCase()==v['nicename'].toString().toLowerCase()){
              conId = v['id'].toString();
            }
          }
        });


      }
    }


  }
  bool show = true;
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
      SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap:(){
                  Navigator.pop(context);
                },
                child: getBackButton(),
              ),
              centerTitle: true,
              title:  getTitle(),
            ),
            backgroundColor: Colors.white,
            body: Stack(
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
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      boxHeight(95),
                      text("Great ! Now some basic details about you",
                          fontFamily: fontMedium,
                          fontSize: 12.sp,
                          textColor:Colors.white
                      ),
                      boxHeight(35),
                      Container(
                        width: getWidth(625),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            text("All Fields are mandatory",
                                fontFamily: fontMedium,
                                fontSize: 9.sp,
                                textColor:Color(0xffFECC2F)
                            ),
                          ],),
                      ),
                      boxHeight(15),
                      Container(
                        width: getWidth(625),
                        padding: EdgeInsets.symmetric(horizontal: getWidth(24),vertical: getHeight(40)),
                        decoration: boxDecoration(
                          radius: 20,
                          showShadow: true,
                          bgColor: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[

                            TextFieldDesigned(
                              controller: emailCon,
                              maxLines: 2,
                              fontSize: 14,
                              maxLength: 30,
                              minLines: 1,
                              hintText: "Email ID",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: mobileCon,
                              maxLines: 2,
                              fontSize: 14,
                              maxLength: 10,
                              minLines: 1,
                              hintText: "Mobile Number",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.phone,
                              prefixIcon: Icon(
                                Icons.call,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            model==null?TextFieldDesigned(
                              controller: passCon,
                              fontSize: 14,
                              maxLength: 25,
                              minLines: 1,
                              obscureText: show,
                              hintText: "Password",
                              hintStyle: Color(0xff000000),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              readOnly: false,
                              keyboardType: TextInputType.text,
                              suffixIcon: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  setState(() {
                                    show = !show;
                                  });
                                },
                                child: Icon(
                                  show
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 24,
                                  color: Colors.black,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ):SizedBox(),
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: dobCon,
                              onTap: () => selectDate(context),
                              readOnly: true,
                              hintStyle: Colors.black,
                              hintText: "Date of birth",
                              suffixIcon: Icon(
                                Icons.calendar_today_outlined,
                                size: 24,
                                color: Colors.black,
                              ),
                              prefixIcon: Icon(
                                Icons.calendar_today_outlined,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: birthCon,
                              onTap: () => selectTime(context),
                              readOnly: true,
                              hintStyle: Colors.black,
                              hintText: "Birth Time",
                              suffixIcon: Icon(
                                Icons.timelapse,
                                size: 24,
                                color: Colors.black,
                              ),
                              prefixIcon: Icon(
                                Icons.timer,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            TextFieldDesigned(
                              controller: placeCon,
                              minLines: 1,
                              maxLines: 3,
                              readOnly: false,
                              hintStyle: Colors.black,
                              keyboardType: TextInputType.text,
                              hintText: "Location Of Birth Place",
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Color(0xffCCD2E3),
                                size: 16.0,
                              ),
                            ),
                            boxHeight(35),
                            // conList.length>0?DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //
                            //     hint: Row(
                            //       children: const [
                            //         SizedBox(
                            //           width: 4,
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             "Country",
                            //             style: TextStyle(
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.w400,
                            //               fontFamily: fontMedium,
                            //               color: Colors.black,
                            //             ),
                            //             overflow: TextOverflow.ellipsis,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     items: conList
                            //         .map((item) => DropdownMenuItem<String>(
                            //       value: item.id ,
                            //       child: Text(
                            //         item.name.toString(),
                            //         style: const TextStyle(
                            //           fontSize: 14,
                            //           fontFamily: fontMedium,
                            //           color: Colors.black,
                            //         ),
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ))
                            //         .toList(),
                            //     value: conId,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         conId= value as String;
                            //       });
                            //
                            //     },
                            //     icon: const Icon(
                            //       Icons.keyboard_arrow_down,
                            //       color: Colors.black,
                            //     ),
                            //     iconOnClick: const Icon(
                            //       Icons.keyboard_arrow_up,
                            //       color: Colors.black,
                            //     ),
                            //     iconSize: 14,
                            //     iconEnabledColor: Colors.white,
                            //     iconDisabledColor: Colors.grey,
                            //     buttonHeight: 50,
                            //     buttonWidth: double.infinity,
                            //     buttonPadding:
                            //     const EdgeInsets.only(left: 14, right: 14),
                            //     dropdownPadding:
                            //     EdgeInsets.only(left: 14, right: 14),
                            //     buttonDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       border: Border.all(
                            //         color: Color(0xffc5c4c7),
                            //         //36325A
                            //       ),
                            //       color: Colors.white,
                            //       //image: DecorationImage(image: AssetImage(BORDER_PNG)),
                            //     ),
                            //     //buttonElevation: 2,
                            //     itemHeight: 40,
                            //     itemPadding: EdgeInsets.only(left: 10, right: 10),
                            //     dropdownMaxHeight: 200,
                            //     //   dropdownWidth: 350,
                            //     dropdownDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       //color: Color(0xff211D4A),
                            //     ),
                            //     dropdownElevation: 8,
                            //     scrollbarRadius: const Radius.circular(40),
                            //     scrollbarThickness: 5,
                            //     scrollbarAlwaysShow: true,
                            //
                            //     /*offset: const Offset(20, 0),*/
                            //   ),
                            // ):SizedBox(),
                            DropdownSearch<CountryModel>(
                              mode: Mode.DIALOG,
                              showSelectedItem:false,
                              items: conList,
                              itemAsString: (CountryModel u) => u.nicename.toString(),
                              hint: "select",
                              onChanged: (value){
                                conId = value!.id.toString();
                                print("selected country id" + value.id.toString());
                              },
                              showSearchBox: true,
                              filterFn: (instance, filter){
                                if(instance.nicename!.toLowerCase().contains(filter)){
                                  print("filer value here" + filter.toString());
                                  return true;
                                }
                                else{
                                  return false;
                                }
                              },
                              searchBoxController: searchController,

                              popupItemBuilder: (context,CountryModel item,bool isSelected){
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: !isSelected
                                      ? null
                                      : BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(item.nicename.toString()),
                                  ),
                                );
                              },
                            ),
                          ],),
                      ),
                      boxHeight(70),
                      Center(
                        child: InkWell(
                          onTap: (){
                            if(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email")!=null){
                              setSnackbar(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email").toString(), context);
                              return;
                            }
                            if(mobileCon.text==""||mobileCon.text.length!=10){
                              setSnackbar("Please Enter Mobile Number", context);
                              return;
                            }
                            if(model==null&&passCon.text==""){
                              setSnackbar("Please Enter Valid Password", context);
                              return;
                            }
                            if(dobCon.text==""){
                              setSnackbar("Please Select Date Of Birth", context);
                              return;
                            }
                            if(birthCon.text==""){
                              setSnackbar("Please Select Time Of Birth", context);
                              return;
                            }
                            if(placeCon.text==""){
                              setSnackbar("Please Enter Birth Place", context);
                              return;
                            }
                            if(conId==null){
                              setSnackbar("Please Select Country", context);
                              return;
                            }
                            param['email']= emailCon.text;
                            param['mobile']= mobileCon.text;
                            if(model==null){
                              param['password']= passCon.text;
                            }
                            param['dob']= dobCon.text;
                            param['birth_place']= placeCon.text;
                            param['birth_time']= birthCon.text;
                            param['country']= conId;
                            print("checking other params ${param}");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_three_view(param)));
                          },
                          child: Container(
                            width: getWidth(625),
                            height: getHeight(95),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0,1],
                                  colors: <Color>[Color(0xff4292EB), Color(0xff63BEF5),]),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: text("Continue",
                                  fontFamily: fontMedium,
                                  fontSize: 14.sp,
                                  textColor: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      boxHeight(59),
                    ],),
                ),
              ],
            )
        ),
      );
  }
}



