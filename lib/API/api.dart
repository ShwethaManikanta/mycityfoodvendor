import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycityfoodvendor/model/image_api_models.dart';
import 'package:mycityfoodvendor/model/login.dart';
import 'package:mycityfoodvendor/model/misc.dart';
import 'package:mycityfoodvendor/model/orderhistory.dart';
import 'package:mycityfoodvendor/model/profile_model.dart';
import 'package:mycityfoodvendor/model/restaruant_type_model.dart';
import 'package:mycityfoodvendor/model/search_categorylist.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';

API getapi = API();

class API {
  static SharedPreferences? sharedPreferences;
  static final String baseUrl =
      "https://chillkrt.in/Mycities/Mycities_food/index.php/api/Api_vendor";
  static String? filevalueres;
  static String? imageLink;
  static ProfileModel? profileModel;
  static dynamic? userData;
  static String? user;

  Future<LoginModel?> reg(param) async {
    var url = Uri.parse('$baseUrl/reg');
    print(url);
    print("==== Data $param");
    var response = await http.post(url, body: param);
    print(response.statusCode);
    print(response.body.toString());
    var response1 = LoginModel.fromJson(jsonDecode(response.body));
    if (response1.status == "1") {
      print(response1.status);
      print(response);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response1;
    }
    return null;
  }

  Future<String?> register(param) async {
    var response = await Dio().post('$baseUrl/doupload', data: param);
    print('Response data: ${response.data}');
    print('Response status: ${response.statusCode}');
    filevalueres = response.data['file_name'];
    imageLink = response.data['file_url'];
    print('Response body: ${response.data['file_name']}');
    print('Response link: $imageLink');
    return filevalueres;
  }

  Future<ImageUploadResponse?> uploadImage(File imagePath) async {
    ImageUploadResponse? imageUploadResponse;
    final uri = Uri.parse('$baseUrl/doupload');
    var multiPartRequest = http.MultipartRequest("POST", uri);
    multiPartRequest.fields['file_type'] = "product";
    multiPartRequest.files
        .add(await http.MultipartFile.fromPath('file_name', imagePath.path));
    var result = await multiPartRequest.send();

    final response = await http.Response.fromStream(result);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      imageUploadResponse = ImageUploadResponse.fromJson(jsonResponse);
    }
    return imageUploadResponse;

    // var response = await Dio().post(
    //     'https://chillkrt.in/closetobuy/index.php/api/Api_vendor/doupload',
    //     data: param);
    // print('Response data: ${response.data}');
    // print('Response status: ${response.statusCode}');
    // filevalueres = response.data['file_name'];
    // imageLink = response.data['file_url'];
    // print('Response body: ${response.data['file_name']}');
    // print('Response link: ${imageLink}');
  }

  //  Future<ImageUploadResponse?> uploadMultipleImage(List<File> imageFiles) async {
  //   ImageUploadResponse? imageUploadResponse;
  //   final uri = Uri.parse(
  //       'https://chillkrt.in/closetobuy/index.php/api/Api_vendor/doupload');
  //   var multiPartRequest = http.MultipartRequest("POST", uri);
  //   multiPartRequest.fields['file_type'] = "product";
  //   multiPartRequest.files
  //       .add(await http.MultipartFile.fromPath('file_name', imagePath.path));
  //   var result = await multiPartRequest.send();

  //   final response = await http.Response.fromStream(result);

  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(response.body);
  //     imageUploadResponse = ImageUploadResponse.fromJson(jsonResponse);
  //   }
  //   return imageUploadResponse;

  //   // var response = await Dio().post(
  //   //     'https://chillkrt.in/closetobuy/index.php/api/Api_vendor/doupload',
  //   //     data: param);
  //   // print('Response data: ${response.data}');
  //   // print('Response status: ${response.statusCode}');
  //   // filevalueres = response.data['file_name'];
  //   // imageLink = response.data['file_url'];
  //   // print('Response body: ${response.data['file_name']}');
  //   // print('Response link: ${imageLink}');
  // }

  Future<ImageUploadResponse?> uploadImageByAsset(
    Asset asset,
  ) async {
    print("API WORK");
    ImageUploadResponse? imageUploadResponse;
    final uri = Uri.parse('$baseUrl/doupload');
    http.MultipartRequest multiPartRequest = http.MultipartRequest("POST", uri);
    ByteData byteData = await asset.getByteData();
    print("response.get buyte data -------------- $byteData");
    List<int> imageData = byteData.buffer.asUint8List();
    multiPartRequest.fields['file_type'] = "product";
    multiPartRequest.files.add(http.MultipartFile.fromBytes(
        'file_name', imageData,
        filename: "file_name"));
    var result = await multiPartRequest.send();

    final response = await http.Response.fromStream(result);

    if (response.statusCode == 200) {
      print("response.statusCode -------------- ${response.statusCode}");
      print("response.statusCode -------------- ${response.body}");

      final jsonResponse = jsonDecode(response.body);
      imageUploadResponse = ImageUploadResponse.fromJson(jsonResponse);
      print("Image upload reponse file name" +
          imageUploadResponse.fileName.toString());
    }
    return imageUploadResponse;

    // var response = await Dio().post(
    //     'https://chillkrt.in/closetobuy/index.php/api/Api_vendor/doupload',
    //     data: param);
    // print('Response data: ${response.data}');
    // print('Response status: ${response.statusCode}');
    // filevalueres = response.data['file_name'];
    // imageLink = response.data['file_url'];
    // print('Response body: ${response.data['file_name']}');
    // print('Response link: ${imageLink}');
  }

  // Future<ImageUploadResponse?> uploadListImageByAsset(
  //   Asset asset,
  // ) async {
  //   List<MultipartFile> multipartImageList = <MultipartFile>[];
  //   ByteData byteData = await asset.getByteData();
  //   List<int> imageData = byteData.buffer.asUint8List();
  //   // await
  //   // for (Asset asset in assets) {
  //   MultipartFile multipartFile = new MultipartFile.fromBytes(
  //     imageData,
  //   );
  //   // }

  //   FormData formData =
  //       FormData.fromMap({"multipartFiles": multipartImageList, "userId": '1'});

  //   Dio dio = new Dio();
  //   var response = await dio.post(
  //       'https://chillkrt.in/closetobuy/index.php/api/Api_vendor/doupload',
  //       data: formData);

  //   // print("API WORK");
  //   // ImageUploadResponse? imageUploadResponse;
  //   // final uri = Uri.parse(
  //   //     'https://chillkrt.in/closetobuy/index.php/api/Api_vendor/doupload');
  //   // http.MultipartRequest multiPartRequest = http.MultipartRequest("POST", uri);
  //   // ByteData byteData = await asset.getByteData();
  //   // List<int> imageData = byteData.buffer.asUint8List();
  //   // Future.delayed(Duration(milliseconds: 10));
  //   // multiPartRequest.fields['file_type'] = "product";
  //   // // multiPartRequest.files
  //   // //     .add(http.MultipartFile.fromBytes('file_name', imageData));
  //   // var result = await multiPartRequest.send();

  //   // final response = await http.Response.fromStream(result);

  //   // if (response.statusCode == 200) {
  //   //   print("response.statusCode -------------- ${response.statusCode}");
  //   //   print("response.statusCode -------------- ${response.body}");

  //   //   final jsonResponse = jsonDecode(response.body);
  //   //   imageUploadResponse = ImageUploadResponse.fromJson(jsonResponse);
  //   //   print("Image upload reponse file name" +
  //   //       imageUploadResponse.fileName.toString());
  //   // }
  //   return imageUploadResponse;

  //   // var response = await Dio().post(
  //   //     'https://chillkrt.in/closetobuy/index.php/api/Api_vendor/doupload',
  //   //     data: param);
  //   // print('Response data: ${response.data}');
  //   // print('Response status: ${response.statusCode}');
  //   // filevalueres = response.data['file_name'];
  //   // imageLink = response.data['file_url'];
  //   // print('Response body: ${response.data['file_name']}');
  //   // print('Response link: ${imageLink}');
  // }

  // Future<void> multipartUpload(List<Asset> imagesList) async {
  //   try {
  //     var uri = Uri.parse(
  //         'https://chillkrt.in/closetobuy/index.php/api/Api_vendor/doupload');
  //     http.MultipartRequest request = new http.MultipartRequest('POST', uri);

  //     request.fields['userid'] = '1';
  //     request.fields['food_name'] = 'piza';
  //     request.fields['category'] = 'piza';
  //     request.fields['serving_no'] = '3';
  //     request.fields['post_type'] = 'Global';
  //     request.fields['cooking_date'] = '2020-12-09';
  //     request.fields['exchange_for'] = 'yes';
  //     request.fields['spice_level'] = '2';
  //     request.fields['private_address'] = 'yes';
  //     request.fields['address'] = 'nothing';
  //     request.fields['city'] = 'Peshawar';
  //     request.fields['state'] = 'KP';
  //     request.fields['zipcode'] = '2500';
  //     request.fields['allergies'] = 'No';
  //     request.fields['diet_specific'] = 'egg';
  //     request.fields['include_ingredients'] = 'egg, butter';
  //     request.fields['exclude_ingredients'] = 'egg butter';
  //     request.fields['details'] = 'nothing';

  //     List<http.MultipartFile> newList = <http.MultipartFile>[];

  //     for (int i = 0; i < imagesList.length; i++) {
  //       var path =
  //           await FlutterAbsolutePath.getAbsolutePath(imagesList[i].identifier);
  //       File imageFile = File(path);

  //       var stream = new http.ByteStream(imageFile.openRead());
  //       var length = await imageFile.length();

  //       var multipartFile = new http.MultipartFile("pictures", stream, length,
  //           filename: basename(imageFile.path));
  //       newList.add(multipartFile);
  //     }

  //     request.files.addAll(newList);
  //     var response = await request.send();
  //     print(response.toString());

  //     response.stream.transform(utf8.decoder).listen((value) {
  //       print('value');
  //       print(value);
  //     });

  //     if (response.statusCode == 200) {
  //       print('uploaded');
  //     } else {
  //       print('failed');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<LoginModel?> logins(BuildContext context, param) async {
    final response = await http.post(Uri.parse('$baseUrl/login'), body: param);
    print("param +$param");
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print("param1 +");
      var response1 = LoginModel.fromJson(jsonDecode(response.body));
      print(response1);
      print(response1.status);
      if (response1.status == "1") {
        print("Response ----------------- ${response1.status}");
        // Toast.show(response1.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
        var userId = response1.driver_details!.id!;
        print("userId +$userId");
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("USER", userId);
        getUserId("USER");
        return response1;
      } else if (response1.status == "0") {
        // Toast.show(response1.message, context,
        //     duration: 2,
        //     backgroundColor: Colors.green,
        //     backgroundRadius: 10,
        //     gravity: Toast.CENTER);
      }
    } else {
      print("error");
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<SearchFood?> searchFood(String type, String searchKey) async {
    final response = await http.post(Uri.parse('$baseUrl/listcategory'),
        body: {"type": type, "search_key": searchKey});

    print("Response body ____)-----" + response.body);

    if (response.statusCode == 200) {
      var search = SearchFood.fromJson(jsonDecode(response.body));
      if (search.status == "1") {
        print(response.body);
        return search;
      } else {
        print("1 st If ");
      }
    } else {
      print("error");
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<RestaruantTypeModel?> mainRestaruant(
      String type, String searchKey) async {
    final response = await http.post(
      Uri.parse('$baseUrl/listoutlets'),
    );

    print("Response body ____)-----" + response.body);

    if (response.statusCode == 200) {
      var searchRes = RestaruantTypeModel.fromJson(jsonDecode(response.body));
      if (searchRes.status == "1") {
        print(response.body);
        return searchRes;
      } else {
        print("1 st If ");
      }
    } else {
      print("error");
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<MallListResponseModel?> mallList() async {
    final response = await http.post(
      Uri.parse('$baseUrl/mall_list'),
    );

    print("Response body ____)-----" + response.body);

    if (response.statusCode == 200) {
      var searchRes = MallListResponseModel.fromJson(jsonDecode(response.body));
      if (searchRes.status == "1") {
        print(response.body);
        return searchRes;
      } else {
        print("1 st If ");
      }
    } else {
      print("error");
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ForgotModel?> forgotPassword(BuildContext context, param) async {
    print(param);
    final response =
        await http.post(Uri.parse('$baseUrl/forgotPassword'), body: param);

    if (response.statusCode == 200) {
      var forgot = ForgotModel.fromJson(jsonDecode(response.body));
      if (forgot.status == "1") {
        // Toast.show(forgot.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
        // print(response.body);

        return forgot;
      } else {
        // Toast.show(forgot.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      print("error");
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ForgotModel?> changePassword(BuildContext context, param) async {
    print(param);
    final response =
        await http.post(Uri.parse('$baseUrl/changepassword'), body: param);

    if (response.statusCode == 200) {
      var forgot = ForgotModel.fromJson(jsonDecode(response.body));
      if (forgot.status == "1") {
        // Toast.show(forgot.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
        print(response.body);

        return forgot;
      } else {
        // Toast.show(forgot.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ForgotModel?> rebtaurantOnOff(BuildContext context, param) async {
    print(param);
    final response =
        await http.post(Uri.parse('$baseUrl/res_on_off'), body: param);

    if (response.statusCode == 200) {
      var restaurant = ForgotModel.fromJson(jsonDecode(response.body));
      print(response.body);
      print(restaurant.status);
      if (restaurant.status == "1") {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
        print(response.body);
        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<OrderCancelledModel?> orderHistory(BuildContext context) async {
    final response = await http.post(Uri.parse('$baseUrl/order_history'),
        body: {"outlet_id": API.userData});

    if (response.statusCode == 200) {
      var restaurant = OrderCancelledModel.fromJson(jsonDecode(response.body));
      if (restaurant.status == "1") {
        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<OrderCancelledModel?> orderCompleted(BuildContext context) async {
    final response = await http.post(Uri.parse('$baseUrl/order_completed'),
        body: {"user_id": API.userData});

    if (response.statusCode == 200) {
      var restaurant = OrderCancelledModel.fromJson(jsonDecode(response.body));
      if (restaurant.status == "1") {
        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ForgotModel?> withdrawList(BuildContext context) async {
    final response = await http.post(Uri.parse('$baseUrl/withdraw_list'),
        body: {"outlet_id": API.userData});
    if (response.statusCode == 200) {
      var restaurant = ForgotModel.fromJson(jsonDecode(response.body));
      print(restaurant);
      if (restaurant.status == "1") {
        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ForgotModel?> getMenuList(BuildContext context) async {
    final response = await http.post(Uri.parse('$baseUrl/get_menu_list'),
        body: {"outlet_id": API.userData});
    if (response.statusCode == 200) {
      var restaurant = ForgotModel.fromJson(jsonDecode(response.body));
      print(restaurant);
      if (restaurant.status == "1") {
        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ForgotModel?> menuOnOff(BuildContext context, param) async {
    final response =
        await http.post(Uri.parse('$baseUrl/menu_on_off'), body: param);
    if (response.statusCode == 200) {
      var restaurant = ForgotModel.fromJson(jsonDecode(response.body));
      print(restaurant);
      if (restaurant.status == "1") {
        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ForgotModel?> foodtype(BuildContext context, param) async {
    final response =
        await http.post(Uri.parse('$baseUrl/food_type_change'), body: param);
    if (response.statusCode == 200) {
      var restaurant = ForgotModel.fromJson(jsonDecode(response.body));
      print(restaurant);
      if (restaurant.status == "1") {
        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ForgotModel?> acceptcancelorder(BuildContext context, param) async {
    final response =
        await http.post(Uri.parse('$baseUrl/order_accept_reject'), body: param);
    if (response.statusCode == 200) {
      var restaurant = ForgotModel.fromJson(jsonDecode(response.body));
      print(restaurant);
      if (restaurant.status == "1") {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);

        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ForgotModel?> requestwithdraw(BuildContext context, param) async {
    final response =
        await http.post(Uri.parse('$baseUrl/request_withdraw'), body: param);
    if (response.statusCode == 200) {
      var restaurant = ForgotModel.fromJson(jsonDecode(response.body));
      print(restaurant);
      if (restaurant.status == "1") {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);

        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<OrderCancelledModel?> orderCancelledList(BuildContext context) async {
    final response = await http.post(Uri.parse('$baseUrl/order_cancelled_list'),
        body: {"user_id": API.userData});

    if (response.statusCode == 200) {
      var restaurant = OrderCancelledModel.fromJson(jsonDecode(response.body));
      if (restaurant.status == "1") {
        return restaurant;
      } else {
        // Toast.show(restaurant.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ProfileModel?> editProfile(BuildContext context, param) async {
    print(param);
    final response =
        await http.post(Uri.parse('$baseUrl/profile_update'), body: param);

    if (response.statusCode == 200) {
      var response1 = ProfileModel.fromJson(jsonDecode(response.body));
      if (response1.status == "1") {
        print(response.body);
        // Toast.show(response1.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
        return response1;
      } else {
        // Toast.show(response1.message, context,
        //     duration: 2, backgroundColor: Colors.green, backgroundRadius: 10);
      }
    } else {
      print("error");
      throw Exception('Failed to load album');
    }
    return null;
  }

  Future<ProfileModel> fetchAlbum(param) async {
    final response =
        await http.post(Uri.parse('$baseUrl/profile'), body: param);

    if (response.statusCode == 200) {
      print(response.body);
      return ProfileModel.fromJson(jsonDecode(response.body));
    } else {
      print("error");
      throw Exception('Failed to load album');
    }
  }

  static void getUserId(String key) async {
    final prefs = await SharedPreferences.getInstance();
    userData = (prefs.getString(key) ?? '');

    print("userData +$userData");
  }

  static void logout(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
