import 'dart:io';
import 'package:mycityfoodvendor/Pages/pick_location_google_maps_screen.dart';
import 'package:mycityfoodvendor/common/common_styles.dart';
import 'package:mycityfoodvendor/model/restaruant_type_model.dart';
import 'package:mycityfoodvendor/service/sign_up_api_provider.dart';
import 'package:mycityfoodvendor/service/validate_email_phone.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/common/utils.dart';
import 'package:mycityfoodvendor/service/image_picker_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpResponse extends StatefulWidget {
  const SignUpResponse({Key? key}) : super(key: key);

  @override
  _SignUpResponseState createState() => _SignUpResponseState();
}

class _SignUpResponseState extends State<SignUpResponse> {
  final restaurantNameKey = GlobalKey<FormState>();
  final mobileNoKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  final adderessKey = GlobalKey<FormState>();
  final fssaiKey = GlobalKey<FormState>();
  final fssaiExpKey = GlobalKey<FormState>();
  final gstKey = GlobalKey<FormState>();
  final carryBagKey = GlobalKey<FormState>();
  final deliveryTimeKey = GlobalKey<FormState>();
  final desCriptionKey = GlobalKey<FormState>();
  final panKey = GlobalKey<FormState>();
  final areaKey = GlobalKey<FormState>();
  final upiKey = GlobalKey<FormState>();

  final restaurantNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final fssaiNoController = TextEditingController();
  final fssaiExpDateController = TextEditingController();
  final gstController = TextEditingController();
  final carryBagController = TextEditingController();
  final deliveryTimeController = TextEditingController();
  final descripitionController = TextEditingController();
  final panController = TextEditingController();
  final areaController = TextEditingController();
  final upiController = TextEditingController();

  File? image;
  String profileimage = '';

  File? fssai_Image;
  String fssai_ImagePath = '';

  File? gstImg;
  String gstImgPath = '';

  File? panImageFile;
  String panImagePath = '';

  File? chequeImg;
  String chequeImgPath = '';

  File? menuImg;
  String menuImgPath = '';

  String group_value = "1";

  String select_food_type = "3";

  String main_sub_value = "1";

  String deliveryChoice = "1";

  dynamic latitude = '';
  dynamic longitude = '';
  String selectedAddress = '';

  bool _obscureText = true;

  List<String> httpResponse = <String>[];

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  List<File> multipleSelectedMenuImages = [];

  // void locatePosition() async {
  //   bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

  //   await Geolocator.checkPermission();
  //   await Geolocator.requestPermission();

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   currentPosition = position;
  //   LatLng latLngPosition = LatLng(position.latitude, position.longitude);

  //   // Ask permission from device
  //   Future<void> requestPermission() async {
  //     await Permission.location.request();
  //   }
  // }

  bool checkBoxValue = false;

  bool location = false;

  int selectedId = 0, selectedFoddCourtId = 0;
  List<String> res_Name = [], foodCourtAddressName = [];
  List<String> id = [], foodCourtAddressId = [];
  List<String> description = [];

  late OutletList _selectedOutlet;
  bool _subRestaurantNameLoading = false;
  bool _foodCourtListingLoading = true;
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey(); //so we can call snackbar from anywhere

  Future getMainRestaruant() async {
    final result =
        await getapi.mainRestaruant(main_sub_value == "main" ? "1" : "2", "");
    print("---Rest Length-----------${result!.outletList!.length}");
    result.outletList!.forEach((element) {
      res_Name.add(element.outletName!);
      id.add(element.id!);
      description.add(element.description!);
    });
    print("food Length${res_Name.length}");
    return res_Name;
  }

  Future getFoodCourtListing() async {
    //Calls get list or foodCourtCourtAddress and assigns string value for each of them
    final result = await getapi.mallList();
    print("---Rest Length-----------${result!.mallList!.length}");
    foodCourtAddressId.clear();
    foodCourtAddressName.clear();
    result.mallList!.forEach((element) {
      foodCourtAddressName.add(element.mallName!);
      foodCourtAddressId.add(element.id!);
    });
    print("food Length${res_Name.length}");
    return res_Name;
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerService = Provider.of<ImagePickerService>(context);
    final validateEmailPhoneProvider =
        Provider.of<ValidateEmailPhoneNumberProvider>(context);
    final signUpAPIProvider = Provider.of<SignUpApiProvider>(
      context,
    );
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Profile Image Required *',
                    style: CommonStyles.error8TextStyle(),
                  ),
                ),
              ),

              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        image =
                            await imagePickerService.chooseImageFile(context);
                        if (image == null || image!.path == File('').path) {
                          Utils.getSnackBar(
                              context, "No Profile Image Selected");
                        } else {
                          setState(() {});
                        }
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.orange[900],
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  image!,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                ))
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Resturant Name *".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                key: restaurantNameKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value == null) {
                        return "Resturant Name is required feild .(*)";
                      }
                      if (value.length < 3) {
                        return "Please check given name";
                      }
                      return null;
                    },
                    controller: restaurantNameController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Restaurant Name",
                      // errorStyle: CommonStyles.errorRed10TestStyle(),
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
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Restaurant Type".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: Colors.green,
                          value: "1",
                          groupValue: main_sub_value,
                          onChanged: (value) {
                            setState(() {
                              main_sub_value = value.toString();
                              descripitionController.text = "";
                              print(main_sub_value);
                            });
                          }),
                      Text("Main Restaurant")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: Colors.red,
                          value: "2",
                          groupValue: main_sub_value,
                          onChanged: (value) async {
                            setState(() {
                              main_sub_value = value.toString();
                              _subRestaurantNameLoading = false;
                            });
                            await getMainRestaruant();
                            setState(() {
                              _subRestaurantNameLoading = true;
                            });
                            print(main_sub_value);
                          }),
                      Text("Sub Restarunat")
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: main_sub_value == "2",
                child: _subRestaurantNameLoading
                    ? Column(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: DropdownSearch(
                                mode: Mode.DIALOG,
                                items: res_Name,
                                selectedItem: res_Name[selectedId],
                                onChanged: (value) {
                                  print(value.toString());
                                  int index =
                                      res_Name.indexOf(value!.toString());
                                  print(id[index]);
                                  selectedId = index;
                                  descripitionController.text =
                                      description[selectedId];

                                  print("selected --- id" +
                                      selectedId.toString());
                                  setState(() {});
                                },
                                showSearchBox: true,
                                enabled: true,
                                dropdownSearchDecoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(0)),
                              )),
                        ],
                      )
                    : SizedBox(
                        height: 65,
                        width: deviceWidth(context),
                        child: Center(child: Utils.getLoadingCenter25()),
                      ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Delivery Service".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: Colors.green,
                          value: "1",
                          groupValue: deliveryChoice,
                          onChanged: (value) {
                            setState(() {
                              deliveryChoice = value.toString();
                            });
                          }),
                      Text("Service Required")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: Colors.red,
                          value: "2",
                          groupValue: deliveryChoice,
                          onChanged: (value) async {
                            setState(() {
                              deliveryChoice = value.toString();
                            });
                            print(deliveryChoice);
                          }),
                      Text("Self Delivery")
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Mobile Number *".toUpperCase(),
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Form(
                  key: mobileNoKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    controller: mobileController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 10,
                    validator: (value) {
                      if (value!.length != 10) {
                        return "Please Enter Valid Number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter Your Mobile Number",
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
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Email *".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                key: emailKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value!)) {
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
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Password *".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                key: passwordKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    // keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "Minimum 6 characters";
                      }
                      return null;
                    },
                    controller: passwordController,
                    cursorColor: Colors.black,

                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
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
                height: 25,
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: Text(
              //     "Address *".toUpperCase(),
              //     style: TextStyle(
              //         color: (Colors.orange[900])!,
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Form(
              //   key: adderessKey,
              //   child: Container(
              //     margin: const EdgeInsets.symmetric(horizontal: 20),
              //     padding: EdgeInsets.symmetric(horizontal: 5),
              //     child: TextFormField(
              //       keyboardType: TextInputType.multiline,
              //       cursorColor: Colors.black,
              //       controller: addressController,
              //       decoration: InputDecoration(
              //         hintText: "Enter Your Restaurant Address",
              //         hintStyle: TextStyle(color: Colors.black26),
              //         labelStyle: TextStyle(color: Colors.black),
              //         enabledBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(
              //             color: (Colors.orange[600])!,
              //           ),
              //         ),
              //         focusedBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(
              //             color: (Colors.orange[900])!,
              //           ),
              //         ),
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              //         fillColor: Colors.white,
              //         isDense: true,
              //         filled: true,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 25,
              // ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Area *".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: areaKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    cursorColor: Colors.black,
                    controller: areaController,
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return 'Enter valid area';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Restaurant Landmark",
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
              location
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () async {
                          LocationPermission permission;
                          permission = await Geolocator.requestPermission();
                          if (permission == LocationPermission.denied) {
                            permission = await Geolocator.requestPermission();
                            if (permission ==
                                LocationPermission.deniedForever) {
                              Utils.getSnackBar(context,
                                  "Oops!! Location Permission is denied");
                              return Future.error('Location Not Available');
                            }
                            Utils.getSnackBar(context,
                                "Oops!! Location Permission is denied");
                          } else {
                            showLoadingWithCustomText(
                                context, "Getting Locaiton");
                            final position =
                                await Geolocator.getCurrentPosition();

                            Navigator.of(context).pop();

                            final Map<String, dynamic> result =
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PickLocationGoogleMapsScreen(
                                              latitude: position.latitude,
                                              longitude: position.longitude,
                                            )));
                            setState(() {
                              latitude = result['latitude'];
                              longitude = result['longitude'];
                              selectedAddress = result['address'];
                              location = true;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.location_on,
                                color: (Colors.orange[900])!),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                              selectedAddress,
                              style: CommonStyles.textDataBlack12(),
                            )),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              !location
                  ? InkWell(
                      onTap: () async {
                        LocationPermission permission;
                        permission = await Geolocator.requestPermission();
                        if (permission == LocationPermission.denied) {
                          permission = await Geolocator.requestPermission();
                          if (permission == LocationPermission.deniedForever) {
                            Utils.getSnackBar(context,
                                "Oops!! Location Permission is denied");
                            return Future.error('Location Not Available');
                          }
                          Utils.getSnackBar(
                              context, "Oops!! Location Permission is denied");
                        } else {
                          showLoadingWithCustomText(
                              context, "Getting Locaiton");
                          final position =
                              await Geolocator.getCurrentPosition();

                          Navigator.of(context).pop();
                          final Map<String, dynamic> result =
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PickLocationGoogleMapsScreen(
                                            latitude: position.latitude,
                                            longitude: position.longitude,
                                          )));
                          setState(() {
                            latitude = result['latitude'];
                            longitude = result['longitude'];
                            selectedAddress = result['address'];
                            location = true;
                          });
                        }
                        // final position =
                        //     await GeolocatorService().determinePosition();
                        // if (position != null) {
                        //   Navigator.of(context).pop();
                        //   final Map<String, dynamic> result =
                        //       await Navigator.of(context).push(
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   PickLocationGoogleMapsScreen(
                        //                     latitude: position.latitude,
                        //                     longitude: position.longitude,
                        //                   )));
                        //   setState(() {
                        //     latitude = result['latitude'];
                        //     longitude = result['longitude'];
                        //     selectedAddress = result['address'];
                        //     location = true;
                        //   });
                        // } else {
                        //   Navigator.of(context).pop();

                        //   Utils.getSnackBar(
                        //       context, "Oops!! Location Permission is denied");
                        // }
                        // await Geolocator.getCurrentPosition()
                        //     .then((Position position) {
                        //   setState(() {
                        //     latitude = position.latitude;
                        //     longitude = position.longitude;
                        //     location = true;
                        //     print("latval + ${position.latitude}");
                        //     print("longval + ${position.longitude}");
                        //   });
                        // }).catchError((e) {
                        //   print(e);
                        // });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: (Colors.orange[900])!)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Select Location From Map")
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Perparing Time".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                key: deliveryTimeKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    controller: deliveryTimeController,
                    decoration: InputDecoration(
                      hintText: "Preparing Time (Only Mints)",
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
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Type of Bussiness".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 8),
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: deviceWidth(context) * 0.35,
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Colors.green,
                              value: "1",
                              groupValue: group_value,
                              onChanged: (value) {
                                setState(() {
                                  group_value = value.toString();
                                  print(group_value);
                                });
                              }),
                          Expanded(
                              child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "Restaurant",
                              overflow: TextOverflow.fade,
                            ),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth(context) * 0.3,
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Colors.red,
                              value: "2",
                              groupValue: group_value,
                              onChanged: (value) {
                                setState(() {
                                  group_value = value.toString();
                                  print(group_value);
                                });
                              }),
                          Expanded(
                            child: Text(
                              "Meat",
                              overflow: TextOverflow.fade,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth(context) * 0.3,
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Colors.red,
                              value: "3",
                              groupValue: group_value,
                              onChanged: (value) async {
                                setState(() {
                                  group_value = value.toString();
                                  _foodCourtListingLoading = true;
                                });
                                await getFoodCourtListing();
                                setState(() {
                                  _foodCourtListingLoading = false;
                                });
                              }),
                          Expanded(
                              child: Text(
                            "Bakery",
                            overflow: TextOverflow.fade,
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth(context) * 0.3,
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Colors.red,
                              value: "4",
                              groupValue: group_value,
                              onChanged: main_sub_value == "2"
                                  ? (value) {
                                      Utils.getSnackBar(context,
                                          "Cannot Select food court as sub-restaurant please change it to main-restaurant");
                                    }
                                  : (value) async {
                                      setState(() {
                                        group_value = value.toString();
                                        _foodCourtListingLoading = true;
                                        print(group_value);
                                      });
                                      await getFoodCourtListing();
                                      setState(() {
                                        _foodCourtListingLoading = false;
                                      });
                                    }),
                          Expanded(
                              child: Text(
                            "Food Court",
                            overflow: TextOverflow.fade,
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: group_value == "4",
                child: _foodCourtListingLoading
                    ? SizedBox(
                        height: 65,
                        width: deviceWidth(context),
                        child: Center(child: Utils.getLoadingCenter25()),
                      )
                    : Column(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: DropdownSearch(
                                mode: Mode.DIALOG,
                                items: foodCourtAddressName,
                                selectedItem:
                                    foodCourtAddressName[selectedFoddCourtId],
                                onChanged: (value) {
                                  print(value.toString());
                                  int index = foodCourtAddressName
                                      .indexOf(value!.toString());

                                  selectedFoddCourtId = index;

                                  print("selected --- id" +
                                      selectedFoddCourtId.toString());
                                  print("selected mall" +
                                      foodCourtAddressName[
                                          selectedFoddCourtId]);
                                  print("selected mall id" +
                                      foodCourtAddressId[selectedFoddCourtId]);

                                  setState(() {});
                                },
                                showSearchBox: true,
                                enabled: true,
                                dropdownSearchDecoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(0)),
                              )),
                        ],
                      ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Type of Food".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: deviceWidth(context) * 0.33,
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Colors.green,
                              value: "1",
                              groupValue: select_food_type,
                              onChanged: group_value == "2"
                                  ? (value) {
                                      Utils.getSnackBar(context,
                                          "Can't select veg when type of business is meat.");
                                    }
                                  : (value) {
                                      setState(() {
                                        select_food_type = value.toString();
                                        print(select_food_type);
                                      });
                                    }),
                          Expanded(
                              child: Text(
                            "Veg",
                            overflow: TextOverflow.fade,
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth(context) * 0.3,
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Colors.red,
                              value: "2",
                              groupValue: select_food_type,
                              onChanged: (value) {
                                setState(() {
                                  select_food_type = value.toString();
                                  print(select_food_type);
                                });
                              }),
                          Expanded(
                              child:
                                  Text("Non-Veg", overflow: TextOverflow.fade))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth(context) * 0.3,
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Colors.red,
                              value: "3",
                              groupValue: select_food_type,
                              onChanged: (value) {
                                setState(() {
                                  select_food_type = value.toString();
                                  print(select_food_type);
                                });
                              }),
                          Expanded(
                              child: Text("All", overflow: TextOverflow.fade))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /* SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Carry Bag Charge".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),*/
              /* SizedBox(
                height: 5,
              ),
              Form(
                key: carryBagKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    controller: carryBagController,
                    decoration: InputDecoration(
                      hintText: "Enter Carry Bag Charge",
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
              ),*/
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Fssai Image".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 150,
                  width: MediaQuery.of(context).size.width * 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.deepOrange, width: 2)),
                  child: GestureDetector(
                    onTap: () async {
                      fssai_Image =
                          await imagePickerService.chooseImageFile(context);

                      if (fssai_Image == null ||
                          fssai_Image!.path == File('').path) {
                        Utils.getSnackBar(context, "No FSSAI Image Selected");
                      } else {
                        setState(() {});
                      }

                      // _showPicker(context, "fssai");
                    },
                    child: fssai_Image != null &&
                            fssai_Image!.path != File('').path
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              fssai_Image!,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("ADD FSSAI IMAGE",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.camera_alt,
                                size: 35,
                              )
                            ],
                          ),
                  )),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: group_value != "2"
                              ? Text(
                                  "Fssai Number *".toUpperCase(),
                                  style: TextStyle(
                                      color: (Colors.orange[900])!,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "Fssai Number".toUpperCase(),
                                  style: TextStyle(
                                      color: (Colors.orange[900])!,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: fssaiKey,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                print("The group value  --------  " +
                                    group_value);
                                if (group_value != "2") {
                                  if (value == null) {
                                    return '* Mandatory';
                                  }
                                  if (value.isEmpty || value.length < 4) {
                                    return '* Mandatory';
                                  }
                                }
                                return null;
                              },
                              controller: fssaiNoController,
                              decoration: InputDecoration(
                                hintText: "Enter FSSAI Number",
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
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                fillColor: Colors.white,
                                isDense: true,
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: group_value != "2"
                              ? Text(
                                  "Fssai Expiry Date *".toUpperCase(),
                                  style: TextStyle(
                                      color: (Colors.orange[900])!,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "Fssai Expiry Date".toUpperCase(),
                                  style: TextStyle(
                                      color: (Colors.orange[900])!,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: fssaiExpKey,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.datetime,
                              cursorColor: Colors.black,
                              controller: fssaiExpDateController,
                              readOnly: true,
                              validator: (value) {
                                if (group_value != "2") {
                                  if (value == null) {
                                    return '* Mandatory';
                                  }
                                  if (value.isEmpty || value.length < 4) {
                                    return '* Mandatory';
                                  }
                                }
                                return null;
                              },
                              maxLength: 10,
                              onTap: () async {
                                final currentDateTime = DateTime.now();
                                final firstDate = DateTime(
                                    currentDateTime.year - 50,
                                    currentDateTime.month,
                                    currentDateTime.day,
                                    currentDateTime.hour);
                                final lastDate = DateTime(
                                    currentDateTime.year + 50,
                                    currentDateTime.month,
                                    currentDateTime.day,
                                    currentDateTime.hour);
                                final pickedDateTime = await showDatePicker(
                                    context: context,
                                    initialDate: currentDateTime,
                                    firstDate: firstDate,
                                    lastDate: lastDate);

                                if (pickedDateTime == null) {
                                  Utils.getSnackBar(
                                      context, "Date Not Selected");
                                } else {
                                  fssaiExpDateController.text =
                                      pickedDateTime.day.toString() +
                                          "/" +
                                          pickedDateTime.month.toString() +
                                          "/" +
                                          pickedDateTime.year.toString();
                                  Utils.getSnackBarDuration(
                                      context,
                                      "Selected Date Time " +
                                          pickedDateTime.day.toString() +
                                          "/" +
                                          pickedDateTime.month.toString() +
                                          "/" +
                                          pickedDateTime.year.toString(),
                                      Duration(seconds: 5));
                                }
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                hintText: "dd/mm/yyyy".toUpperCase(),
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
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                fillColor: Colors.white,
                                isDense: true,
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "GST Image".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 150,
                  width: MediaQuery.of(context).size.width * 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.deepOrange, width: 2)),
                  child: GestureDetector(
                    onTap: () async {
                      gstImg =
                          await imagePickerService.chooseImageFile(context);

                      if (gstImg == null || gstImg!.path == File('').path) {
                        Utils.getSnackBar(context, "No GST Image Selected");
                      } else {
                        setState(() {});
                      }
                      // _showPicker(context, "gst");
                    },
                    child: gstImg != null && gstImg!.path != File('').path
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              gstImg!,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("ADD GST IMAGE",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.camera_alt,
                                size: 35,
                              )
                            ],
                          ),
                  )),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Gst Number".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                key: gstKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    controller: gstController,
                    decoration: InputDecoration(
                      hintText: "Enter GST Number",
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
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Pan Image".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 150,
                  width: MediaQuery.of(context).size.width * 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.deepOrange, width: 2)),
                  child: GestureDetector(
                    onTap: () async {
                      panImageFile =
                          await imagePickerService.chooseImageFile(context);

                      if (panImageFile == null ||
                          panImageFile!.path == File('').path) {
                        Utils.getSnackBar(context, "No PAN Image Selected");
                      } else {
                        setState(() {});
                      }
                      // _showPicker(context, "gst");
                    },
                    child: panImageFile != null &&
                            panImageFile!.path != File('').path
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              panImageFile!,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("ADD PAN IMAGE",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.camera_alt,
                                size: 35,
                              )
                            ],
                          ),
                  )),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "PAN Number *".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                key: panKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    controller: panController,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Enter Valid Pan Number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter PAN Number",
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
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "UPI ID".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                key: upiKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    controller: upiController,
                    validator: (value) {
                      // if (value == null || value.length < 6) {
                      //   return "Enter Valid Pan Number";
                      // }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter UPI Number",
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
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Menu Image".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              multipleSelectedMenuImages.isEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      height: 150,
                      width: MediaQuery.of(context).size.width * 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.deepOrange, width: 2)),
                      child: GestureDetector(
                          onTap: () async {
                            // FilePickerResult? result =
                            //     await FilePicker.platform.pickFiles(
                            //   allowMultiple: true,
                            //   type: FileType.custom,
                            //   allowedExtensions: ['jpg', 'png', 'jpeg'],
                            // );
                            // if (result != null &&
                            //     result.files.first.path != File('').path) {
                            //   multipleSelectedMenuImages = result.paths
                            //       .map((path) => File(path!))
                            //       .toList();
                            //   setState(() {});
                            //   print(multipleSelectedMenuImages);
                            // }
                            loadMultipleImages();

                            // setState(() {
                            // loadAssets();
                            //   print("Work");
                            // });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("ADD MENU IMAGES",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.camera_alt,
                                size: 35,
                              )
                            ],
                          )))
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      height: 200,
                      child: buildGridView(),
                    ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "CHEQUE Image ".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 150,
                  width: MediaQuery.of(context).size.width * 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.deepOrange, width: 2)),
                  child: GestureDetector(
                    onTap: () async {
                      chequeImg =
                          await imagePickerService.chooseImageFile(context);

                      if (chequeImg == null ||
                          chequeImg!.path == File('').path) {
                        Utils.getSnackBar(context, "No Cheque Image Selected");
                      } else {
                        setState(() {});
                      }
                      // _showPicker(context, "cheque");
                    },
                    child: chequeImg != null && chequeImg!.path != File('').path
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              chequeImg!,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("ADD CHEQUE IMAGE",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.camera_alt,
                                size: 35,
                              )
                            ],
                          ),
                  )),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Description ".toUpperCase(),
                  style: TextStyle(
                      color: (Colors.orange[900])!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: desCriptionKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: descripitionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.deepOrange, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.deepOrange, width: 2)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: checkBoxValue == true
                      ? () async {
                          validateEmailPhoneProvider.initialize();
                          signUpAPIProvider.initialize();
                          if (selectedAddress != "" ||
                              latitude != null ||
                              longitude != null) {
                            if (restaurantNameKey.currentState!.validate() &&
                                mobileNoKey.currentState!.validate() &&
                                emailKey.currentState!.validate() &&
                                passwordKey.currentState!.validate() &&
                                areaKey.currentState!.validate() &&
                                panKey.currentState!.validate() &&
                                fssaiKey.currentState!.validate() &&
                                fssaiExpKey.currentState!.validate()) {
                              showLoadingWithCustomText(
                                  context, "Valadating User...");
                              await validateEmailPhoneProvider
                                  .validateEmailAndPhone(
                                      email: emailController.text,
                                      phoneNumber: mobileController.text);
                              Navigator.of(context).pop();
                              if (validateEmailPhoneProvider.error) {
                                showErrorMessage(context,
                                    validateEmailPhoneProvider.errorMessage);
                              } else if (validateEmailPhoneProvider.response !=
                                      null &&
                                  validateEmailPhoneProvider.response!.status ==
                                      "1") {
                                if (image != null &&
                                        image!.path != File('').path
                                    // gstImg != null &&
                                    // gstImg!.path != File('').path &&
                                    // chequeImg != null &&
                                    // chequeImg!.path != File('').path

                                    ) {
                                  showLoadingWithCustomText(
                                      context, "Uploading Images...");

                                  // final uploadImage =
                                  //     await getapi.uploadImageByAsset(images.first);

                                  // multipleSelectedMenuImages
                                  //     .forEach((element) async {
                                  //   final result = await uploadMenuImage(element);
                                  //   Future.delayed(Duration(microseconds: 100));
                                  //   path += result! + ",";
                                  // });

                                  // print(
                                  //     "imageResponse status -------------------- $path");
                                  // if (images.isNotEmpty) {
                                  //   images.forEach((element) async {
                                  //     // File file =
                                  //     //     await getImageFileFromAssets(element);
                                  //     // await file.exists().then((value) async {
                                  //     //   final string = await uploadMenuImage(file);
                                  //     //   print("The value is " + string.toString());
                                  //     // });
                                  //     final imageResponse =
                                  //         await getapi.uploadImageByAsset(element);
                                  //     print("The image response object " +
                                  //         imageResponse!.fileName.toString());
                                  //     if (imageResponse.status == "1") {
                                  //       print(
                                  //           "imageResponse status -------------------- ${imageResponse.status}");
                                  //       httpResponse.add(imageResponse.fileName!);
                                  //     }
                                  //   });
                                  // }

                                  // httpResponse.forEach((element) {
                                  //   imagesString += element + ",";
                                  // });
                                  // print('Uploaded image string' + imagesString);
                                  // print("Add cheque image " + );
                                  // print("Restaurant Name      " +
                                  //     restaurantNameController.text);
                                  // print(
                                  //     "Main sub restaurant selected Type      " +
                                  //         main_sub_value.toString());
                                  // print("SubRestaurant selected Id      " +
                                  //             main_sub_value ==
                                  //         "1"
                                  //     ? ""
                                  //     : selectedId.toString());
                                  // print("Restaurant  Movile Number      " +
                                  //     mobileController.text);
                                  // print("Restaurant Email      " +
                                  //     emailController.text);
                                  // print("Restaurant Password      " +
                                  //     passwordController.text);
                                  // print("Restaurant selected address      " +
                                  //     restaurantNameController.text);
                                  // print("Restaurant preparing time      " +
                                  //     deliveryTimeController.text);
                                  // print("Restaurant type of business      " +
                                  //     group_value);

                                  // print("Restaurant type of food      " +
                                  //     select_food_type);

                                  // print(" resaurant fssai Number" +
                                  //     fssaiNoController.text);
                                  // print(" resaurant fssai Expiry" +
                                  //     fssaiExpDateController.text);
                                  // print(" resaurant gst Number" +
                                  //     gstController.text);
                                  // print(" resaurant description " +
                                  //     descripitionController.text);

                                  String menuCardImage = '';
                                  print(
                                      "upload profile image ------------- **************");
                                  await uploadProfileImage();
                                  print(
                                      "upload profile image *************************** ");

                                  if (chequeImg != null &&
                                      chequeImg!.path != File('').path) {
                                    await updateChequeImage();
                                  }

                                  if (fssai_Image != null &&
                                      fssai_Image!.path != File('').path) {
                                    await uploadFssaiImage();
                                  }
                                  if (gstImg != null &&
                                      gstImg!.path != File('').path) {
                                    await updateGstImage();
                                  }
                                  if (panImageFile != null &&
                                      panImageFile!.path != File('').path) {
                                    await updatePANImage();
                                  }
                                  for (File imageFile
                                      in multipleSelectedMenuImages) {
                                    final result =
                                        await uploadMenuImage(imageFile);
                                    menuCardImage += result! + ",";
                                    await Future.delayed(
                                        Duration(microseconds: 100));
                                  }

                                  Navigator.of(context).pop();

                                  Map<String, dynamic> param = {};
                                  param.addAll({'type': main_sub_value});
                                  param.addAll({
                                    'outlet_id': id.isEmpty
                                        ? ""
                                        : id[selectedId].toString()
                                  });
                                  param.addAll({'email': emailController.text});
                                  param.addAll(
                                      {'password': passwordController.text});
                                  param.addAll({'profile_image': profileimage});
                                  param.addAll({'athar_image': '12.jpg'});
                                  param.addAll({'gst_image': gstImgPath});
                                  param
                                      .addAll({'fssai_image': fssai_ImagePath});
                                  param.addAll(
                                      {'bank_checklist_image': chequeImgPath});
                                  param.addAll(
                                      {'fssai_number': fssaiNoController.text});
                                  param.addAll({'gst': gstController.text});
                                  param.addAll({'food_type': group_value});
                                  param.addAll(
                                      {'restaurant_type': select_food_type});
                                  param.addAll({
                                    'res_name': restaurantNameController.text
                                  });
                                  param.addAll(
                                      {'mobile': mobileController.text});

                                  param.addAll({
                                    'mall_id': foodCourtAddressId.isEmpty
                                        ? "0"
                                        : foodCourtAddressId[
                                            selectedFoddCourtId]
                                  });
                                  param.addAll({'address': selectedAddress});
                                  param.addAll({
                                    'description': descripitionController.text
                                  });
                                  param.addAll({'lat': latitude.toString()});
                                  param.addAll({'upi_id': upiController.text});
                                  param.addAll({'long': longitude.toString()});
                                  param.addAll({
                                    'accept_terms': checkBoxValue ? "1" : "0"
                                  });
                                  param.addAll(
                                      {'mall_id': checkBoxValue ? "1" : "0"});

                                  param.addAll({
                                    'fssai_expiry_date':
                                        fssaiExpDateController.text
                                  });
                                  param.addAll({'pan_image': panImagePath});
                                  param.addAll(
                                      {'pan_number': panController.text});
                                  param.addAll({
                                    'preparing_time':
                                        deliveryTimeController.text
                                  });
                                  param.addAll({'area': areaController.text});
                                  param.addAll(
                                      {'delivery_partner': deliveryChoice});
                                  //  param.addAll({'carry_bag': carryBagController.text});
                                  param.addAll(
                                      {'menu_card_image': menuCardImage});
                                  String? token = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  param.addAll({'device_token': token ?? "NA"});

                                  showLoadingWithCustomText(
                                      context, "Uploading Details...");
                                  await signUpAPIProvider.signUp(
                                      requestMap: param);
                                  Navigator.of(context).pop();
                                  if (signUpAPIProvider.error) {
                                    showErrorMessage(context,
                                        signUpAPIProvider.errorMessage);
                                  } else if (signUpAPIProvider.signUpResponse ==
                                          null ||
                                      signUpAPIProvider
                                              .signUpResponse!.status! ==
                                          "0") {
                                    showErrorMessage(
                                        context,
                                        signUpAPIProvider
                                            .signUpResponse!.message!);
                                  } else {
                                    Utils.getSnackBar(
                                        context, "Sign Up Successful!!");
                                    Navigator.of(context).pop();
                                  }

                                  // print("--------- ${param}");
                                  // await getapi.reg(param).then((value) {
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(SnackBar(
                                  //           content: Text(
                                  //     "Register Successfully",
                                  //     textAlign: TextAlign.center,
                                  //   )));
                                  //   Navigator.pushReplacementNamed(
                                  //       context, 'LoginPage');
                                  // });
                                } else {
                                  print("Else --------------");
                                  if (image == null ||
                                      image!.path == File('').path) {
                                    Utils.getSnackBar(context,
                                        "Please Upload Restaurant Profile Image");
                                  }
                                }
                              } else {
                                Utils.getSnackBar(
                                    context,
                                    validateEmailPhoneProvider
                                        .response!.message!);
                              }
                            } else {
                              if (restaurantNameKey.currentState!.validate() ==
                                  false) {
                                Utils.getSnackBar(context,
                                    "Please Give Valid Restaurant Name");
                              }
                              if (mobileNoKey.currentState!.validate() ==
                                  false) {
                                Utils.getSnackBar(
                                    context, "Please Give Valid Phone Number");
                              }
                              if (emailKey.currentState!.validate() == false) {
                                Utils.getSnackBar(
                                    context, "Please Give Valid Email");
                              }
                              if (passwordKey.currentState!.validate() ==
                                  false) {
                                Utils.getSnackBar(
                                    context, "Please Give Valid Password");
                              }
                              if (areaKey.currentState!.validate() == false) {
                                Utils.getSnackBar(
                                    context, "Please Give Valid Area");
                              }
                              if (panKey.currentState!.validate() == false) {
                                Utils.getSnackBar(
                                    context, "Please Give Valid Pan Key");
                              }
                              if (fssaiKey.currentState!.validate() == false) {
                                Utils.getSnackBar(
                                    context, "Please Give Valid FSSAI");
                              }
                              if (fssaiExpKey.currentState!.validate() ==
                                  false) {
                                Utils.getSnackBar(context,
                                    "Please Give Valid FSSAI Expiry Key");
                              }
                            }
                          } else {
                            Utils.getSnackBar(context,
                                "Please Select Accurate Location From Map");
                          }
                        }
                      : null,
                  child: Text("Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          (checkBoxValue ? Colors.orange[900] : Colors.grey)!),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        activeColor: Colors.green,
                        value: checkBoxValue,
                        onChanged: (value) {
                          setState(() {
                            checkBoxValue = value!;
                            print(checkBoxValue);
                          });
                        }),
                    Expanded(
                      child: FittedBox(
                        child: InkWell(
                          onTap: () async {
                            const url =
                                'https://closetobuy.com/closetobuy/index.php/api/api_vendor/terms';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: RichText(
                            text: TextSpan(
                                text: "I have ",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text: "Accept",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " the ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Terms",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Conditions",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Already have an account?",
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
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Text("Log In",
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

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    return file;
  }

  // Restarunt Image
  uploadProfileImage() async {
    try {
      FormData formData = FormData.fromMap({
        'file_type': 'retailer',
        'file_name': await MultipartFile.fromFile(image!.path,
            filename: image!.path.split('/').last)
      });
      profileimage = (await getapi.register(formData))!;
      print('Profile Image Uploaded with path' + profileimage);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  uploadFssaiImage() async {
    try {
      FormData formData = FormData.fromMap({
        'file_type': 'retailer',
        'file_name': await MultipartFile.fromFile(fssai_Image!.path,
            filename: fssai_Image!.path.split('/').last)
      });
      fssai_ImagePath = (await getapi.register(formData))!;
      print('Fssai Image Uploaded with path ' + fssai_ImagePath);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  updateGstImage() async {
    try {
      FormData formData = FormData.fromMap({
        'file_type': 'retailer',
        'file_name': await MultipartFile.fromFile(gstImg!.path,
            filename: gstImg!.path.split('/').last)
      });
      gstImgPath = (await getapi.register(formData))!;
      print('Gst Image Image Uploaded with path ' + gstImgPath);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  updatePANImage() async {
    try {
      FormData formData = FormData.fromMap({
        'file_type': 'retailer',
        'file_name': await MultipartFile.fromFile(panImageFile!.path,
            filename: panImageFile!.path.split('/').last)
      });
      panImagePath = (await getapi.register(formData))!;
      print('Gst Image Image Uploaded with path ' + gstImgPath);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  updateChequeImage() async {
    try {
      FormData formData = FormData.fromMap({
        'file_type': 'retailer',
        'file_name': await MultipartFile.fromFile(chequeImg!.path,
            filename: chequeImg!.path.split('/').last)
      });
      chequeImgPath = (await getapi.register(formData))!;
      print('Profile Image Uploaded cheque image path ' + chequeImgPath);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<String?> uploadMenuImage(File file) async {
    try {
      FormData formData = FormData.fromMap({
        'file_type': 'retailer',
        'file_name': await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last)
      });
      return (await getapi.register(formData))!;
    } on PlatformException catch (e) {
      print(e);
    }
    return "";
  }

  List<Asset> images = <Asset>[];
  List<String> path = <String>[];
  String _error = 'No Error Dectected';

  Widget buildGridView() {
    return InkWell(
      onTap: () {
        setState(() {
          loadMultipleImages();
          print("Work");
        });
      },
      child: GridView.count(
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        crossAxisCount: 3,
        children: List.generate(multipleSelectedMenuImages.length, (index) {
          return Image.file(
            multipleSelectedMenuImages[index],
            height: 300,
            width: 300,
          );
          // Asset asset = images[index];
          // return AssetThumb(
          //   asset: asset,
          //   width: 300,
          //   height: 300,
          // );
        }),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    List<String> resultPath = <String>[];
    String error = 'No Error Detected';

    try {
      print("Work 3");
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Select Menu Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
      error = e.toString();
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      path = resultPath;
      _error = error;
    });
  }

  Future<void> loadMultipleImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowCompression: true,
      withData: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null &&
        result.files.first.path != File('').path &&
        result.count <= 10) {
      multipleSelectedMenuImages =
          result.paths.map((path) => File(path!)).toList();
      setState(() {});
      print(multipleSelectedMenuImages);
    } else {
      Utils.getSnackBar(context, "Maximum 10 images allowed.");
    }
  }
}
