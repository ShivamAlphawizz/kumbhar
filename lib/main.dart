
import 'dart:io';

import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/modules/splash/views/splash_view.dart';
import 'package:indianmilan/app/utils/PushNotificationService.dart';
import 'package:indianmilan/app/utils/demoLocalization.dart';
import 'package:sizer/sizer.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/Session.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  runApp( MyApp()
    // Sizer(
    //     builder: (context,orientation,deviceType) {
    //     return GetMaterialApp(
    //       title: "Kumbhar Reshimgath",
    //      // initialRoute: AppPages.INITIAL,
    //       getPages: AppPages.routes,
    //       debugShowCheckedModeBanner: false,
    //       home:
    //       SplashView(),
    //       // Login(),
    //       theme: ThemeData(
    //         /* scaffoldBackgroundColor: const Color(0xFFEFEFEF),*/
    //           scaffoldBackgroundColor: Colors.white,
    //           visualDensity: VisualDensity.adaptivePlatformDensity,
    //           primaryColor: Color(0xff0D0B21),
    //           accentColor: Colors.white,
    //           textSelectionTheme:
    //           TextSelectionThemeData(cursorColor: Colors.black)),
    //     );
    //   }
    // ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocale(Locale locale) {
    if (mounted)
      setState(() {
        _locale = locale;
      });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      if (mounted)
        setState(() {
          this._locale = locale;
        });
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return  Sizer(
        builder: (context,orientation,deviceType) {
        return GetMaterialApp(
          title: "Kumbhar Reshimgath",
         // initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          locale: _locale,
          // Login(),
          supportedLocales: [
            Locale("mr", "IN"),
            Locale("hi", "IN"),
          ],
          localizationsDelegates: [
            CountryLocalizations.delegate,
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          home:
          SplashView(),
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
    );
  }
}



