import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/modules/dashboard/views/dashboard_view.dart';
import 'package:indianmilan/app/modules/login_type/views/login_type_view.dart';
import 'package:indianmilan/app/modules/splash/controllers/splash_controller.dart';
import 'package:indianmilan/app/utils/PushNotificationService.dart';
import 'package:indianmilan/app/utils/constant.dart';
import 'package:indianmilan/app/utils/image_helper.dart';
import 'package:indianmilan/app/utils/location_details.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pushNotificationService = PushNotificationService(
        context: context);
    pushNotificationService.initialise();
    Future.delayed(Duration(seconds: 3)).then((value) {
      changePage();
    });

  }
  changePage()async{
    await App.init();
    if(App.localStorage.getString("userId")!=null){
      curUserId = App.localStorage.getString("userId").toString();
      print(curUserId);
      GetLocation location = new GetLocation((result){
            address = result.first.addressLine;
        latitude = result.first.coordinates.latitude;
        longitude = result.first.coordinates.longitude;
      });
      location.getLoc();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DashboardView(0)), (route) => false);

    }else{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> login_type_View()), (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    //LocalNotificationService.initialize(context);
    return
      // Obx(() => SizedBox(
      //   height: controller.count.value.toDouble(),
      // )),
      Container(
        color: Color(0xff0D0B21),
        child: Stack(
          children: [

            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                BACKGRAOUND_IMAGE,
                fit: BoxFit.fill,
              ),
            ),


            Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Image.asset(
                        SPLASH_IMAGE,
                        width:200,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}