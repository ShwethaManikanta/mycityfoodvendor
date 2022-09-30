import 'dart:async';
import 'package:mycityfoodvendor/common/common_styles.dart';
import 'package:mycityfoodvendor/common/utils.dart';
import 'package:mycityfoodvendor/model/profile_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/Pages/DishesPage.dart';
import 'package:mycityfoodvendor/Pages/OrdersPage.dart';
import 'package:mycityfoodvendor/Pages/ProfilePage.dart';
import 'package:mycityfoodvendor/Pages/product_screen.dart';
import 'package:provider/provider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import '../service/local_notification_services.dart';
import '../service/orders_api_provider.dart';
import '../service/profile_details_api_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode focusNodeName = FocusNode();
  bool status = false;
  List<Widget> body = [
    OrdersPage(),
    ProductScreen(),
    DishesPage(),
    ProfilePage(),
  ];
  int bodyIndex = 0;
  bool on = false;

  get apiService => null;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    //Gives you the message on which user taps
    //and it opened the app is killed
    FirebaseMessaging.instance
        .getToken()
        .then((value) => {print("Token " + value.toString())});

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        context.read<OrderHistoryAPIProvider>().getOrders();
        context.read<OrderCancelledAPIProvider>().getOrders();
        context.read<OrdersCompletedAPIProvider>().getOrders();
        // final routeFromMessage = message.data['route'];
        // Navigator.of(context).pushNamed(routeFromMessage);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));

        LocalNotificationServices.display(message);
      }
    });

    //When the app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      // final routeFromMessage = message.data['route'];
      // if (routeFromMessage != null || routeFromMessage != "") {
      //   Navigator.of(context).pushNamed(routeFromMessage);
      context.read<OrderHistoryAPIProvider>().getOrders();
      context.read<OrderCancelledAPIProvider>().getOrders();
      context.read<OrdersCompletedAPIProvider>().getOrders();
      // }
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));

      print("message" + message.notification!.body!);
      LocalNotificationServices.display(message);
    });

    //When the app is in background but opened and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // final routeFromMessage = message.data['route'];
      // if (routeFromMessage != null || routeFromMessage != "") {
      //   Navigator.of(context).pushNamed(routeFromMessage);
      // }
      // print("message" + message.notification!.body!);
      context.read<OrderHistoryAPIProvider>().getOrders();
      context.read<OrderCancelledAPIProvider>().getOrders();
      context.read<OrdersCompletedAPIProvider>().getOrders();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      LocalNotificationServices.display(message);
    });

    // getProfileData();
    if (context.read<ProfileModelAPIProvider>().profileModel == null) {
      context.read<ProfileModelAPIProvider>().getProfileDetails();
    }
    initializeSoundPremission();
    super.initState();
  }

  initializeSoundPremission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  ProfileModel? _profileModel;
  bool isLoading = true;

  Future<void> getProfileData() async {
    await apiService.fetchAlbum({"user_id": API.userData}).then((value) {
      print("USER ID  --------------------    ----->>>>${API.userData}");
      setState(() {
        _profileModel = value;
        print("-----------------  GET PROFILE DATA");
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppbar(),
        body: buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  buildAppbar() {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    final profileAPIProvider = Provider.of<ProfileModelAPIProvider>(context);
    return AppBar(
        backgroundColor: Color.fromARGB(255, 77, 45, 165),
        automaticallyImplyLeading: false,
        elevation: 0,
        // title: profileAPIProvider.ifLoading
        //     ? SizedBox(
        //         height: 2,
        //         width: deviceWidth(context),
        //         child: LinearProgressIndicator(),
        //       )
        //     : profileAPIProvider.error
        //         ? Utils.showErrorMessage(profileAPIProvider.errorMessage)
        //         : profileAPIProvider.profileModel!.userDetails == null
        //             ? Utils.showErrorMessage(
        //                 profileAPIProvider.profileModel!.message!)
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My City Food Vendor".toUpperCase(),
              style: CommonStyles.textDataWhite15(),
            ),
            Switch(
                value: true,
                // profileAPIProvider.profileModel!.userDetails!.status == "1",
                activeColor: Color.fromARGB(255, 211, 127, 198),
                onChanged: (value) async {
                  profileAPIProvider.profileModel!.userDetails!.status == "1"
                      ? Utils.getSnackBar(context, "Restaurant turning off")
                      : Utils.getSnackBar(context, "Restaurant turning on");
                  Map param = {};
                  param.addAll({"user_id": API.userData});
                  param.addAll({
                    "status":
                        profileAPIProvider.profileModel!.userDetails!.status ==
                                "1"
                            ? "2"
                            : "1"
                  });

                  showLoading(context);
                  await getapi.rebtaurantOnOff(context, param);
                  context.read<ProfileModelAPIProvider>().getProfileDetails();
                  Navigator.of(context).pop();
                })
          ],
        )

        // FormBuilderSwitch(
        //     name: "status",
        //     contentPadding: EdgeInsets.zero,
        //     title: Text(
        //       "Close To Buy Restaurant".toUpperCase(),
        //       style: CommonStyles.textDataBlack12(),
        //     ),
        //     initialValue: profileAPIProvider
        //                 .profileModel!.userDetails!.status ==
        //             "1"
        //         ? true
        //         : false,
        //     focusNode: focusNodeName,
        //     controlAffinity: ListTileControlAffinity.trailing,
        //     decoration: InputDecoration(border: InputBorder.none),
        //     activeColor: Colors.green,
        //     inactiveThumbColor: Colors.grey,
        //     inactiveTrackColor: Colors.grey.withOpacity(0.5),
        //     onChanged: (bool) async {
        //       profileAPIProvider.profileModel!.userDetails!.status ==
        //               "1"
        //           ? Utils.getSnackBar(
        //               context, "Restaurant turning off")
        //           : Utils.getSnackBar(
        //               context, "Restaurant turning on");
        //       Map param = {};
        //       param.addAll({"user_id": API.userData});
        //       param.addAll({
        //         "status": profileAPIProvider
        //                     .profileModel!.userDetails!.status ==
        //                 "1"
        //             ? "2"
        //             : "1"
        //       });
        //       showLoading(context);
        //       await getapi.rebtaurantOnOff(context, param);
        //       context
        //           .read<ProfileModelAPIProvider>()
        //           .getProfileDetails();
        //       Navigator.of(context).pop();
        //     },
        //   ),
        );
  }

  buildBody() {
    return body.elementAt(bodyIndex);
  }

  buildBottomNavigationBar() {
    return TitledBottomNavigationBar(
        activeColor: Colors.deepPurpleAccent,
        inactiveColor: Colors.deepPurpleAccent[200],
        currentIndex: bodyIndex,
        onTap: (index) {
          setState(() {
            bodyIndex = index;
          });
        },
        items: [
          TitledNavigationBarItem(
              title: Text('Orders'.toUpperCase()), icon: Icon(Icons.food_bank)),
          TitledNavigationBarItem(
              title: Text('Products'.toUpperCase()),
              icon: Icon(Icons.production_quantity_limits)),
          TitledNavigationBarItem(
              title: Text('Dishes'.toUpperCase()),
              icon: Icon(Icons.fastfood_rounded)),
          TitledNavigationBarItem(
              title: Text(
                'Profile'.toUpperCase(),
              ),
              icon: Icon(Icons.person_outline)),
        ]);
  }

  /*Future<dynamic> showLogoutDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Do you want to open Restaruant ?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {

                          // Navigator.pushReplacementNamed(context, "LoginPage");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text("Yes",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text("No",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }*/
}
