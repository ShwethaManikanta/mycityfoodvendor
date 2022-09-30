import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mycityfoodvendor/API/api.dart';
import 'package:mycityfoodvendor/Pages/changepassword.dart';

class ForgortPassword extends StatefulWidget {
  @override
  _ForgortPasswordState createState() => _ForgortPasswordState();
}

class _ForgortPasswordState extends State<ForgortPassword> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(100),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/mycitylogo.png",
                          ),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "Mobile Number".toUpperCase(),
                    style: TextStyle(
                        color: (Colors.deepPurple)!,
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
                  child: FormBuilder(
                    key: formKey,
                    child: FormBuilderTextField(
                      name: 'mobile_no',
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Enter Your Mobile Number",
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: (Colors.lightGreenAccent)!,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: (Colors.lightGreenAccent)!,
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
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      formKey.currentState!.save();
                      if (formKey.currentState!.validate()) {
                        print(formKey.currentState!.value);
                        await getapi
                            .forgotPassword(
                                context, formKey.currentState!.value)
                            .then((value) {
                          if (value != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword(
                                        otp: value.otp!,
                                      )),
                            );
                          }
                        });
                      } else {
                        print("validation failed");
                      }
                    },
                    child: Text("Get OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            (Colors.deepPurple)!),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
