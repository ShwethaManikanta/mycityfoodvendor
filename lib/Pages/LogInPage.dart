import 'package:mycityfoodvendor/common/common_styles.dart';
import 'package:mycityfoodvendor/service/add_product_api_provider.dart';
import 'package:mycityfoodvendor/service/login_api_provider.dart';
import 'package:mycityfoodvendor/service/orders_api_provider.dart';
import 'package:mycityfoodvendor/service/recent_product_api_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    // print("API.user!.id  +${API.user!.id}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, bottom: 30.0, right: 20, left: 20),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/splashImg.png",
                        ),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Email".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: emailKey,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    controller: emailController,
                    // name: 'email',
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern);
                      if (value!.isEmpty && !regex.hasMatch(value)) {
                        return "Enter Valid email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(color: Colors.black26),
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: (Colors.orange[600])!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: (Colors.orange[900])!,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Password".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: passwordKey,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: _obscureText,
                    controller: passwordController,
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Provide Password";
                      } else if (value.length < 5) {
                        return "Enter valid password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your password",
                      hintStyle: TextStyle(color: Colors.black26),
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: (Colors.orange[600])!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: (Colors.orange[900])!,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      fillColor: Colors.white,
                      isDense: true,
                      filled: true,
                      suffix: InkWell(
                        onTap: _toggle,
                        child: Text(
                          _obscureText ? "SHOW" : "HIDE",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, bottom: 12, left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Please contact our representatives to change the password!",
                                  style: CommonStyles.textDataBlack12(),
                                  textAlign: TextAlign.center,
                                ),
                                Utils.getSizedBox(height: 20),
                                InkWell(
                                  onTap: () async {
                                    await _makePhoneCall("+91 999999999");
                                  },
                                  child: SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: RadialGradient(colors: [
                                            Colors.white,
                                            Colors.green,
                                          ], tileMode: TileMode.clamp)),
                                      child: Center(
                                          child: Icon(
                                        Icons.phone,
                                        color: Colors.black54,
                                        size: 34,
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                    // Navigator.pushNamed(context, 'ForgortPassword');
                  },
                  child: Text("Forgot Password ?",
                      style: TextStyle(
                          color: (Colors.orange[900])!,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    final loginAPIProvider =
                        Provider.of<LoginAPIProvider>(context, listen: false);
                    if (emailKey.currentState!.validate() &&
                        passwordKey.currentState!.validate()) {
                      showLoadingWithCustomText(context, "Logging In");
                      print(" User Email ------  " +
                          emailController.text +
                          " User Password -----" +
                          passwordController.text);
                      loginAPIProvider.initialize();
                      String? token =
                          await FirebaseMessaging.instance.getToken();
                      print("Get Token --- - -- - - -" + token.toString());
                      await loginAPIProvider.login(
                          email: emailController.text,
                          password: passwordController.text,
                          deviceToken: token!);

                      // await getapi.logins(context, param).then((value) {
                      //   if (value != null) {}
                      // });
                      // Navigator.pushReplacementNamed(context, 'HomePage');

                      if (loginAPIProvider.error) {
                        Navigator.of(context).pop();
                        print("error message 1");
                        showErrorMessage(
                            context, loginAPIProvider.errorMessage);
                      } else if (loginAPIProvider.loginResponse != null &&
                          loginAPIProvider.loginResponse!.status! == "0") {
                        Navigator.of(context).pop();
                        print("error message 2");
                        showErrorMessage(
                            context, loginAPIProvider.loginResponse!.message!);
                      } else {
                        Utils.getSnackBar(context, "Sign In Successful!!!");
                        Navigator.of(context).pop();
                        showLoadingWithCustomText(context, "Valadating User..");
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        await sharedPreferences.setString(
                            "USER",
                            loginAPIProvider.loginResponse!.driverDetails!.id!
                                .toString());
                        API.userData = loginAPIProvider
                            .loginResponse!.driverDetails!.id!
                            .toString();
                        Navigator.of(context).pop();
                        context
                            .read<RecentAddedProductsAPIProvider>()
                            .initialize();

                        context.read<OrderCancelledAPIProvider>().initialize();
                        context.read<OrderHistoryAPIProvider>().initialize();
                        context.read<OrdersCompletedAPIProvider>().initialize();

                        Navigator.pushReplacementNamed(context, 'HomePage');
                      }
                      // Map param = {};
                      // param.addAll({'device_token': '12'});

                      // // param.addAll(formKey.currentState!.value);

                      // await getapi.logins(context, param).then((value) {
                      //   if (value != null) {
                      //     Navigator.pushReplacementNamed(context, 'HomePage');
                      //   }
                      // });
                    } else {
                      Utils.getSnackBar(
                          context, "Please provide with email and password!");
                      print("validation failed");
                    }
                  },
                  child: Text("Log In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          (Colors.orange[900])!),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: (Colors.orange[900])!,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "SignupPage");
                    },
                    child: Container(
                      child: Text("Register",
                          style: TextStyle(
                              color: (Colors.orange[900])!,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
