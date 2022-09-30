import 'package:flutter/material.dart';
import 'package:mycityfoodvendor/common/common_styles.dart';

class Utils {
  static getSizedBox({double height = 0, double width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static getLoadingCenter25() {
    return Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(
          strokeWidth: 0.5,
        ),
      ),
    );
  }

  static Widget showErrorMessage(String errMessage) {
    return Center(
        child: Text(
      errMessage,
      style: CommonStyles.red12(),
    ));
  }

  static getSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          style: CommonStyles.textDataWhite12(),
        )));
  }

  static getSnackBarDuration(
      BuildContext context, String text, Duration duration) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: duration,
        content: Text(
          text,
          style: CommonStyles.textDataWhite12(),
        )));
  }
}

showLoading(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      useSafeArea: false,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.brown[900],
                  backgroundColor: Colors.brown[100],
                ),
                Utils.getSizedBox(height: 20),
                Text(
                  "Loading",
                  style: CommonStyles.textw200BlueS14(),
                ),
              ],
            ),
          ),
        );
      });
}

showLoadingWithCustomText(BuildContext context, String text) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      useSafeArea: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Colors.brown[900],
                    backgroundColor: Colors.brown[100],
                  ),
                  Utils.getSizedBox(height: 20),
                  Text(
                    text,
                    style: CommonStyles.textw200BlueS14(),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

showAuthenticating(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.brown[900],
                  backgroundColor: Colors.brown[100],
                ),
                Utils.getSizedBox(height: 20),
                Text(
                  "Authenticating",
                  style: CommonStyles.textw200BlueS14(),
                ),
              ],
            ),
          ),
        );
      });
}

showValidating(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.brown[900],
                  backgroundColor: Colors.brown[100],
                ),
                Utils.getSizedBox(height: 20),
                Text(
                  "Validating",
                  style: CommonStyles.textw200BlueS14(),
                ),
              ],
            ),
          ),
        );
      });
}

//
showErrorMessage(BuildContext context, String message) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.info,
                          size: 60,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: message.length > 200
                              ? FittedBox(
                                  child: Text(
                                    message,
                                    maxLines: 4,
                                    overflow: TextOverflow.fade,
                                    style: CommonStyles.errorTextStyleStyle(),
                                  ),
                                )
                              : Text(
                                  message,
                                  maxLines: 4,
                                  overflow: TextOverflow.fade,
                                  style: CommonStyles.errorTextStyleStyle(),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        elevation: 2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Center(
                            child: Text(
                              "OK!",
                              style: CommonStyles.errorRed10TestStyle(),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
