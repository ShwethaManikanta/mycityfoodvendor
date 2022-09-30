import 'package:mycityfoodvendor/service/limit_list_api_provider.dart';
import 'package:mycityfoodvendor/service/local_notification_services.dart';
import 'package:mycityfoodvendor/service/login_api_provider.dart';
import 'package:mycityfoodvendor/service/menu_list_api_provider.dart';
import 'package:mycityfoodvendor/service/orders_api_provider.dart';
import 'package:mycityfoodvendor/service/profile_details_api_provider.dart';
import 'package:mycityfoodvendor/service/sign_up_api_provider.dart';
import 'package:mycityfoodvendor/service/validate_email_phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/API/update_product_api.dart';
import 'package:mycityfoodvendor/Pages/LogInPage.dart';
import 'package:mycityfoodvendor/Pages/ForgetPasswordPage.dart';
import 'package:mycityfoodvendor/Pages/HomePage.dart';
import 'package:mycityfoodvendor/Pages/OnboardingPage.dart';
import 'package:mycityfoodvendor/Pages/ProfilePage.dart';
import 'package:mycityfoodvendor/Pages/SplashScreen.dart';
import 'package:mycityfoodvendor/Pages/signup_responsse.dart';
import 'package:mycityfoodvendor/service/add_product_api_provider.dart';
import 'package:mycityfoodvendor/service/image_picker_service.dart';
import 'package:mycityfoodvendor/service/recent_product_api_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

//Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  final routeFromMessage = message.data['route'];
  LocalNotificationServices.display(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationServices.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.getInstance().token.addOnCompleteListener {
    //     if (!it.isSuccessful) {
    //         return@addOnCompleteListener
    //     }
    //     val token = it.result //this is the token retrieved
    // }
    API.getUserId('USER');
    print("main + ${API.userData}");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ImagePickerService>(create: (_) => ImagePickerService()),
        ChangeNotifierProvider<AddProductAPiProvider>(
            create: (_) => AddProductAPiProvider()),
        ChangeNotifierProvider<RecentAddedProductsAPIProvider>(
            create: (_) => RecentAddedProductsAPIProvider()),
        ChangeNotifierProvider<UpdateProductAPIProvider>(
            create: (_) => UpdateProductAPIProvider()),
        ChangeNotifierProvider<SignUpApiProvider>(
            create: (_) => SignUpApiProvider()),
        ChangeNotifierProvider<LoginAPIProvider>(
            create: (_) => LoginAPIProvider()),
        ChangeNotifierProvider<OrderCancelledAPIProvider>(
            create: (_) => OrderCancelledAPIProvider()),
        ChangeNotifierProvider<OrderHistoryAPIProvider>(
            create: (_) => OrderHistoryAPIProvider()),
        ChangeNotifierProvider<OrdersCompletedAPIProvider>(
            create: (_) => OrdersCompletedAPIProvider()),
        ChangeNotifierProvider<ValidateEmailPhoneNumberProvider>(
            create: (_) => ValidateEmailPhoneNumberProvider()),
        ChangeNotifierProvider<ProfileModelAPIProvider>(
            create: (_) => ProfileModelAPIProvider()),
        ChangeNotifierProvider<LimitListAPIProvider>(
            create: (_) => LimitListAPIProvider()),
        ChangeNotifierProvider<MenuListAPIProvider>(
            create: (_) => MenuListAPIProvider()),
      ],
      child: MaterialApp(
        title: 'Close To Buy Vendor',
        supportedLocales: [
          // Locale('in', 'IN'),
          Locale('en', 'US'),
        ],
        locale: Locale('in'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          primaryColor: (Colors.orange[900])!,
        ),
        routes: {
          'SplashScreen': (context) => SplashScreen(),
          'HomePage': (context) => HomePage(),
          'ProfilePage': (context) => ProfilePage(),
          'LoginPage': (context) => LoginPage(),
          'Onboarding': (context) => Onboarding(),
          'SignupPage': (context) => SignUpResponse(),
          'ForgortPassword': (context) => ForgortPassword(),
        },
        initialRoute: 'SplashScreen',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
