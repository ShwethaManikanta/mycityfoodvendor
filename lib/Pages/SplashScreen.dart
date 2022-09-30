import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mycityfoodvendor/API/api.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double margin = 100;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (timer.tick <= 6) {
        if (mounted) {
          setState(() {
            margin = margin - 2;
          });
        }
      } else {
        timer.cancel();
        API.userData != ""
            ? Navigator.pushReplacementNamed(context, "HomePage")
            : Navigator.pushReplacementNamed(context, "Onboarding");
      }
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        AspectRatio(
          aspectRatio: 1,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/images/splashImg.png"),
              ),
            ),
          ),
        ),
        Spacer(),
        Text(
          '   Restaurant'.toUpperCase(),
          style: TextStyle(
            color: Colors.orange[900],
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        Spacer(),
      ],
    );
  }
}
