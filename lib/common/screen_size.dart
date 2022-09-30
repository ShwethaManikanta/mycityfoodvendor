import 'package:flutter/material.dart';

//Get height of the screen of the screen of given context.
double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//Get width of the screen of the screen of given context.
double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
