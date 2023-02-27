import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indianmilan/app/modules/Home/controllers/HomeNavigation.dart';
import 'package:indianmilan/app/modules/Prime_membership/controllers/Prime_membership_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardController extends GetxController {
  final item = [].obs;
  final advertisementList = <String>[].obs;
  final categoryList_all = [].obs;
  final package_id = 0.obs;
  final bar_title = "".obs;

  final baseUrl_category = "".obs;
  final baseUrl_advertisement = "".obs;
  final baseUrl_event = "".obs;
  final username = "".obs;
  final count = 0.obs;
  final current = 0.obs;
  final bool_isLogin = false.obs;

  String token = "";
  late SharedPreferences prefs;

  final persistentTabController = PersistentTabController();
  bool hideNavBar = false;

  final HomeNavigationController = Get.put(HomeNavigation());
  final Prime_membershipController = Get.put(Prime_membership_controller());
  // final homeController = Get.put(HomeController());
  // final partyDetailController = Get.put(PartyDetailController());
  // final cityListController = Get.put(CityListController());
  // final countryListController = Get.put(CountryListController());
  // final faqController = Get.put(FaqNewController());
  // final settingContrller = Get.put(SettingsController());

  @override
  void onInit() {
    super.onInit();

    hideNavBar = false;
    HomeNavigationController.onInit();
    Prime_membershipController.onInit();
    // discoverGirlController.onInit();
    // //  homeController.onInit();
    // partyDetailController.onInit();
    // cityListController.onInit();
    // countryListController.onInit();
    // settingContrller.onInit();

    /*  FirebaseMessaging.instance.getInitialMessage().then((message) {
      //print('getInitialMessage => display: ${message?.notification?.title}');
      // print('display: ${message?.notification?.body}');
      print('display: ${message?.data.toString()}');
      if (message != null) {
        LocalNotificationService.display(message);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      print('onMessage => display: ${message.notification?.title}');
      print('display: ${message.notification?.body}');
      print('display: ${message.data.toString()}');
      LocalNotificationService.display(message);
    });

    //app open
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("onMessageOpenedApp" + message.toString());
      print('onMessageOpenedApp => display: ${message.notification?.title}');
      print('display: ${message.notification?.body}');
      print('display: ${message.data.toString()}');
      LocalNotificationService.display(message);
    });*/
  }

  @override
  void onClose() {
    HomeNavigationController.onClose();
    Prime_membershipController.onClose();
    // discoverGirlController.onClose();
    // homeController.onClose();
    // partyDetailController.onClose();
    // cityListController.onClose();
    // settingContrller.onClose();
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        title: ("Add"),
        activeColorPrimary: Colors.blueAccent,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.white,
        /* routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/',
            routes: {
              '/first': (context) => MainScreen2(),
              '/second': (context) => MainScreen3(),
            },
          ),
          onPressed: (context) {
            pushDynamicScreen(context,
                screen: SampleModalScreen(), withNavBar: true);
          }*/
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Messages"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
        /* routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),*/
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        /*routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),*/
      ),
    ];

    void increment() => count.value++;
  }
}
