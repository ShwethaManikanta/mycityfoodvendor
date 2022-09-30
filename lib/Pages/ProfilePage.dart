import 'package:mycityfoodvendor/service/profile_details_api_provider.dart';
import 'package:mycityfoodvendor/service/validate_email_phone.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/model/misc.dart';
import 'package:mycityfoodvendor/model/profile_model.dart';
import 'package:provider/provider.dart';

import '../service/login_api_provider.dart';
import '../service/menu_list_api_provider.dart';
import '../service/orders_api_provider.dart';
import '../service/recent_product_api_provider.dart';
import '../service/sign_up_api_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool veg = false;
  bool nonVeg = false;
  bool gst = false;
  bool edit = false;
  Future<ProfileModel>? fetchData;

  List<String> hotelTimmings = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  void initState() {
    super.initState();
    fetchData =
        getapi.fetchAlbum({"user_id": API.userData}) as Future<ProfileModel>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: /* FutureBuilder<ProfileModel> */ ListView.builder(
        itemCount: 1,
        // future: fetchData,
        itemBuilder: (context, snapshot) {
          // if (snapshot.hasData) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                hotelImage(/* snapshot.data! */),
                hotelDetails(/* snapshot.data! */),
                walletDetails(/* snapshot.data! */),
              ],
            ),
          );
          // } else if (snapshot.hasError) {
          //   return Text('${snapshot.error}');
          // }

          // // By default, show a loading spinner.
          // return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }

  Widget hotelImage(/* ProfileModel data */) {
    return AspectRatio(
        aspectRatio: 1,
        child: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: NetworkImage(
                      "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/2/b/f/p20236-1645174524620f5efc8c18a.jpg?tr=tr:n-medium"),
                  // data.profileBaseurl! + data.userDetails!.image!),
                  fit: BoxFit.cover)),
        )
        // Carousel(
        //   dotBgColor: Colors.transparent,
        //   autoplay: false,
        //   dotVerticalPadding: 10,
        //   images: List.generate(1, (index) {
        //     return Stack(
        //       children: [
        //         Tooltip(
        //           message: "Profile image",
        //           child: Container(
        //             margin: EdgeInsets.all(10),
        //             decoration: BoxDecoration(
        //               image: DecorationImage(
        //                 fit: BoxFit.cover,
        //                 image: data.userDetails!.image != ""
        //                     ? NetworkImage("${data.profileBaseurl}" +
        //                         "${data.userDetails!.image!}")
        //                     : NetworkImage(
        //                         "https://thumbs.dreamstime.com/z/default-placeholder-profile-icon-avatar-gray-man-90197971.jpg"),
        //               ),
        //               borderRadius: BorderRadius.circular(20),
        //             ),
        //           ),
        //         ),
        //       ],
        //     );
        //   }),
        // ),
        );
  }

  Widget hotelDetails(/* ProfileModel data */) {
    final formKey = GlobalKey<FormBuilderState>();

    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Restaurant Deatils",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Spacer(),
                /*edit
                    ? IconButton(
                        onPressed: () {
                          formKey.currentState!.save();
                          if (formKey.currentState!.validate()) {
                            print(formKey.currentState!.value);
                            Map param = {};
                            param.addAll({"user_id": API.userData});
                            param.addAll(formKey.currentState!.value);
                            getapi.editProfile(context, param).then((value) =>
                                Navigator.pushNamed(context, 'ProfilePage'));
                          } else {
                            print("validation failed");
                          }
                        },
                        icon: Icon(
                          Icons.check,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                        },
                        icon: Icon(
                          Icons.edit_rounded,
                        ),
                      ),*/
                Container(
                  height: 38,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.redAccent[700],
                  ),
                  child: IconButton(
                      onPressed: () {
                        showLogoutDialog();
                      },
                      icon: Icon(Icons.power_settings_new),
                      color: Colors.white),
                )
              ],
            ),
            FormBuilderTextField(
              name: 'res_name',
              enabled: edit,
              keyboardType: TextInputType.name,
              initialValue: "",
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Restaurant Name'.toUpperCase(),
                labelStyle: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                disabledBorder: InputBorder.none,
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'address',
              enabled: edit,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              initialValue: /* data.userDetails!.outletAddress != ""
                  ? data.userDetails!.outletAddress
                  : */
                  "-",
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Address'.toUpperCase(),
                labelStyle: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                disabledBorder: InputBorder.none,
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'mobile',
              enabled: edit,
              keyboardType: TextInputType.number,
              initialValue: /* data.userDetails!.mobile! */ '99999999999',
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Mobile Number'.toUpperCase(),
                prefixText: "+91 ",
                prefixStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                disabledBorder: InputBorder.none,
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'email',
              enabled: edit,
              keyboardType: TextInputType.emailAddress,
              initialValue: /* data.userDetails!.email! */ '',
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Email'.toUpperCase(),
                labelStyle: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                disabledBorder: InputBorder.none,
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            /* ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Food Type'.toUpperCase(),
                style: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: (Colors.green[700])!)),
                        height: 25,
                        width: 25,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green[700],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Veg',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Switch.adaptive(
                        activeColor: (Colors.orange[900])!,
                        value: data.user_details!.food_type_id !=
                                data.user_details!.food_type_id
                            ? true
                            : false,
                        onChanged: (val) {
                          if (edit) {
                            setState(() {
                              veg = val;
                            });
                            Map param = {
                              "outlet_id": API.userData,
                              "status": "1",
                            };
                            getapi.foodtype(context, param);
                          }
                          print(val);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: (Colors.red[700])!)),
                        height: 25,
                        width: 25,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red[700],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'NonVeg',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Switch.adaptive(
                        activeColor: (Colors.orange[900])!,
                        value: data.user_details!.food_type_id ==
                                data.user_details!.food_type_id
                            ? true
                            : false,
                        onChanged: (val) {
                          if (edit) {
                            setState(() {
                              nonVeg = val;
                            });
                            Map param = {
                              "outlet_id": API.userData,
                              "status": "0",
                            };
                            getapi.foodtype(context, param);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),*/
            /* data.userDetails!.licenseImage != ""
                ? */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Licence image'.toUpperCase(),
                  style: TextStyle(
                    color: (Colors.orange[900])!,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://i.stack.imgur.com/cnOF3.png"
                          /* "${data.profileBaseurl}" +
                          data.userDetails!.licenseImage! */
                          ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            /* data.userDetails!.gstImage != ""
                ?  */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gst image'.toUpperCase(),
                  style: TextStyle(
                    color: (Colors.orange[900])!,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://i.stack.imgur.com/cnOF3.png"
                          /* "${data.profileBaseurl}" +
                          data.userDetails!.gstImage! */
                          ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
            FormBuilderTextField(
              name: 'gst',
              enabled: edit,
              keyboardType: TextInputType.text,
              initialValue: /* data.userDetails!.gstNumber != null
                  ? data.userDetails!.gstNumber!
                  : */
                  "-",
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Gst number'.toUpperCase(),
                labelStyle: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                disabledBorder: InputBorder.none,
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
              ),
            ),
            /* data.userDetails!.fssaiNumber != null ||
                    data.userDetails!.fssaiNumber == ""
                ? FormBuilderTextField(
                    name: 'fssai number',
                    enabled: edit,
                    keyboardType: TextInputType.text,
                    initialValue: data.userDetails!.fssaiNumber != null
                        ? data.userDetails!.fssaiNumber
                        : "-",
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'FSSAI Number'.toUpperCase(),
                      labelStyle: TextStyle(
                        color: (Colors.orange[900])!,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      disabledBorder: InputBorder.none,
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
                    ),
                  )
                : SizedBox(),*/

            SizedBox(
              height: 10,
            ),
            // if (data.userDetails!.fssaiNumber != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'fssai Number'.toUpperCase(),
                  style: TextStyle(
                    color: (Colors.orange[900])!,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "--",
                  // data.userDetails!.fssaiNumber!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),

            /*  FormBuilderTextField(
              name: 'fssai Exp date',
              enabled: edit,
              keyboardType: TextInputType.text,
              initialValue: data.userDetails!.fssaiExpiryDate != null ||
                      data.userDetails!.fssaiExpiryDate == ""
                  ? data.userDetails!.fssaiExpiryDate
                  : "-",
              decoration: InputDecoration(
                isDense: true,
                labelText: 'FSSAI Exp Date'.toUpperCase(),
                labelStyle: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                disabledBorder: InputBorder.none,
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
              ),
            ),*/

            // if (data.userDetails!.fssaiExpiryDate != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'fssai Expiry Date'.toUpperCase(),
                  style: TextStyle(
                    color: (Colors.orange[900])!,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "--",
                  // data.userDetails!.fssaiExpiryDate!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // if (data.userDetails!.longitude != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'longitude'.toUpperCase(),
                  style: TextStyle(
                    color: (Colors.orange[900])!,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "--",
                  // data.userDetails!.longitude!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // if (data.userDetails!.latitude != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'latitude'.toUpperCase(),
                  style: TextStyle(
                    color: (Colors.orange[900])!,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "--",
                  // data.userDetails!.latitude!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            /* SizedBox(
              height: 10,
            ),
            data.userDetails!.latitude != ""
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Latitude'.toUpperCase(),
                        style: TextStyle(
                          color: (Colors.orange[900])!,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        data.userDetails!.latitude!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            data.userDetails!.longitude != ""
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Longitude'.toUpperCase(),
                        style: TextStyle(
                          color: (Colors.orange[900])!,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        data.userDetails!.longitude!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Container(),*/
            SizedBox(
              height: 10,
            ),
            // if (data.userDetails!.carryBag != null)
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Carry Bag Charge'.toUpperCase(),
            //         style: TextStyle(
            //           color: (Colors.orange[900])!,
            //           fontSize: 14,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       Text(
            //         data.userDetails!.carryBag!,
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 12,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       )
            //     ],
            //   ),
            // if (data.userDetails!.deliveryTime != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Time'.toUpperCase(),
                  style: TextStyle(
                    color: (Colors.orange[900])!,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "15:08",
                  // data.userDetails!.deliveryTime!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showLogoutDialog() {
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
                  Text("Do you want to LogOut ?",
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
                          context.read<ProfileModelAPIProvider>().initialize();
                          context.read<LoginAPIProvider>().initialize();
                          context.read<SignUpApiProvider>().initialize();
                          context.read<MenuListAPIProvider>().initialize();
                          context.read<OrderHistoryAPIProvider>().initialize();
                          context
                              .read<OrderCancelledAPIProvider>()
                              .initialize();
                          context
                              .read<OrdersCompletedAPIProvider>()
                              .initialize();

                          context
                              .read<RecentAddedProductsAPIProvider>()
                              .initialize();
                          context
                              .read<ValidateEmailPhoneNumberProvider>()
                              .initialize();
                          API.logout('USER');
                          Navigator.pushReplacementNamed(context, "LoginPage");
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
  }

  Widget walletDetails(/* ProfileModel profileModel */) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Wallet Details",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Spacer(),
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return dialog();
                    },
                  );
                },
                icon: Icon(Icons.get_app_rounded),
                label: Text("Withdraw".toUpperCase()),
                style: TextButton.styleFrom(
                  primary: (Colors.orange[900])!,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Available Balance".toUpperCase(),
            style: TextStyle(
              color: (Colors.orange[900])!,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          /*  profileModel.userDetails!.requestAmt != ""
              ? Text(
                  "₹ " + profileModel.userDetails!.requestAmt!,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w300,
                  ),
                )
              : */
          Text("-"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Recent Transactions".toUpperCase(),
            style: TextStyle(
              color: (Colors.orange[900])!,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          FutureBuilder<ForgotModel?>(
              future: getapi.withdrawList(context),
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.hasData) {
                  return Column(
                    children: List.generate(
                        snapshot.data!.withdraw_detail_list!.length, (index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "Withdraw",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        subtitle: Text(
                          "${snapshot.data!.withdraw_detail_list![index].date_time}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "₹ " +
                                  snapshot.data!.withdraw_detail_list![index]
                                      .total!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Pending".toUpperCase(),
                              style: TextStyle(
                                color: Colors.yellow[900],
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                }
                return Container();
              }),
        ],
      ),
    );
  }

  Widget dialog() {
    TextEditingController amountcontroller = TextEditingController();
    return Dialog(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 7,
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                'Withdraw'.toUpperCase(),
                style: TextStyle(
                  color: (Colors.orange[900])!,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  wordSpacing: 1,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                maxLines: null,
                autofocus: true,
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter The Amount To Withdraw',
                    border: UnderlineInputBorder(),
                    prefixText: "₹ ",
                    contentPadding: EdgeInsets.all(5)),
                cursorColor: (Colors.orange[900])!,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red[700],
                            elevation: 0,
                            padding: EdgeInsets.all(5)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green[700],
                            elevation: 0,
                            padding: EdgeInsets.all(10)),
                        onPressed: () {
                          Map param = {
                            "outlet_id": API.userData,
                            "amt": amountcontroller.text
                          };
                          print(param);
                          getapi
                              .requestwithdraw(context, param)
                              .then((value) => Navigator.pop(context));
                        },
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              wordSpacing: 1),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
