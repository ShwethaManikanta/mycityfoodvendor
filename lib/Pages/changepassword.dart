import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mycityfoodvendor/API/api.dart';

class ChangePassword extends StatefulWidget {
  final String otp;

  const ChangePassword({Key? key, required this.otp}) : super(key: key);
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final newpasswordController = TextEditingController();

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
            child: FormBuilder(
              key: formKey,
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
                      "Enter OTP".toUpperCase(),
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
                    child: FormBuilderTextField(
                      name: "otp",
                      initialValue: widget.otp,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Enter Your One Time Password",
                        hintStyle: TextStyle(color: Colors.black26),
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: (Colors.lightGreenAccent)!),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: (Colors.lightGreenAccent)!),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                        fillColor: Colors.white,
                        isDense: true,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      " New Password".toUpperCase(),
                      style: TextStyle(
                          color: (Colors.red)!,
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
                    child: FormBuilderTextField(
                      name: 'new_password',
                      controller: newpasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Enter Your Password",
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
                        suffix: InkWell(
                          onTap: _toggle,
                          child: Text(
                            _obscureText ? "SHOW" : "HIDE",
                          ),
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
                          Map param = {};
                          param.addAll({"user_id": API.userData});
                          param.addAll(formKey.currentState!.value);
                          await getapi
                              .changePassword(context, param)
                              .then((value) {
                            if (value != null) {
                              Navigator.pushNamed(context, 'LoginPage');
                            }
                          });
                        } else {
                          print("validation failed");
                        }
                      },
                      child: Text("Reset",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              (Colors.lightGreenAccent)!),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Remember Password?",
                          style: TextStyle(
                            color: (Colors.lightGreenAccent)!,
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
                          child: Text("Go Back",
                              style: TextStyle(
                                  color: (Colors.lightGreenAccent)!,
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
        ),
      ),
    );
  }
}
