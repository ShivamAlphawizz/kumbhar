
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/modules/splash/views/splash_view.dart';
import 'package:indianmilan/app/utils/PushNotificationService.dart';
import 'package:sizer/sizer.dart';
import 'app/routes/app_pages.dart';
// import '../../../../../StudioProjects/vali/lib/login.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


Future<void> main() async {

  /* await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);*/

  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
  runApp(
    Sizer(
        builder: (context,orientation,deviceType) {
        return GetMaterialApp(
          title: "Kumbhar Reshimgath",
         // initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          home:
          SplashView(),
          // Login(),
          theme: ThemeData(
            /* scaffoldBackgroundColor: const Color(0xFFEFEFEF),*/
              scaffoldBackgroundColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primaryColor: Color(0xff0D0B21),
              accentColor: Colors.white,
              textSelectionTheme:
              TextSelectionThemeData(cursorColor: Colors.black)),
        );
      }
    ),
  );
}



