import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ApiService {
  //-------------------------------------sign up---------------------------

  static Future<String> signUp(User user) async {
    var client = http.Client();
    const String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.signup}';
    try {
      final data = {
        "username": user.username,
        "email": user.email,
        "fullname": user.fullname,
        "account_type": user.accountType,
        "phonenumber": user.phoneNo,
        "otp": user.otp,
        "password": user.password
      };
      final response = await client.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      debugPrint('response statusbody signup = ${response.statusCode}');
      debugPrint('response body signup = ${response.body}');
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return 'Success';
      } else if (responseBody['error'] ==
          "Username Already Taken. Please Choose different one or login instead") {
        return "Username exists";
      } else if (responseBody['error'] ==
          "A user with this email address already exist. Please login instead") {
        return "Email address exists";
      } else if (responseBody['error'] ==
          "A user with this Phone Number already exist. Please login instead") {
        return "Phone number exits";
      } else if (responseBody['error'] == 'All fields are Required') {
        return 'All fields are required';
      } else {
        return 'Something went wrong';
      }
    } catch (e) {
      log(e.toString());
      return 'Please try again';
    }
  }

//-----------------------------------------otp---------------------------------

  static Future<bool> createOtp(String email) async {
    var client = http.Client();

    const String url = "${ApiEndPoints.baseUrl}${ApiEndPoints.otp}";

    try {
      final response = await client.post(Uri.parse(url), body: {
        "email": email,
      });
      debugPrint('response statuscode of otp = ${response.statusCode}');
      debugPrint(response.body);
      Map responseBody = jsonDecode(response.body);

      debugPrint('response message :${responseBody['message']}');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //********---------------------------log in-----------------------**********

  static Future<String> logIn(String username, String password) async {
    var client = http.Client();
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.login}';
    try {
      final data = {"username": username, "password": password};
      final response = await client.post(Uri.parse(url), body: data);

      final responseBody = jsonDecode(response.body);

      debugPrint(response.body);
      final token = responseBody['token'].toString();

      //------store token in sharedpreference--------
      saveToken(token);

      debugPrint("log in statuscode == ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("log in succefull");

        return 'Success';
      } else if (responseBody['error'] == 'Invalid Password') {
        return 'Invalid Password';
      } else if (responseBody['error'] == "Invalid Username") {
        return "Invalid Username";
      } else if (responseBody['error'] == "Parameters Missing") {
        return "Parameters Missing";
      } else {
        return '';
      }
    } catch (e) {
      log(e.toString());
      return 'server unavailable';
    }
  }

  //------------------------forgot password--------------------

  static Future<String> forgotPassword(
      String email, String password, String otp) async {
    var client = http.Client();
    var url = "${ApiEndPoints.baseUrl}${ApiEndPoints.forgotPassword}";
    try {
      final data = {"email": email, "otp": otp, "password": password};
      final response = await client.post(Uri.parse(url), body: data);
      final resposeBody = jsonDecode(response.body);

      print(response.body);
      print("statuscode of forgot password === ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        return 'Success';
      } else if (resposeBody['error'] == "The OTP is not valid") {
        return 'The OTP is not valid';
      } else {
        return '';
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  static Future<String> forgotPasswordotp(String email) async {
    var client = http.Client();
    var url = "${ApiEndPoints.baseUrl}${ApiEndPoints.forgotPasswordOtp}";
    try {
      final data = {"email": email};
      final response = await client.post(Uri.parse(url), body: data);
      final responseBody = jsonDecode(response.body);
      debugPrint(response.body);
      debugPrint(
          "statuscode of forgot password otp === ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        return "Success";
      } else if (responseBody['error'] ==
          "User not found in this EmailID try Creating new Account") {
        return 'User not found in this Email';
      } else {
        return '';
      }
    } catch (e) {
      log(e.toString());
      return 'Server unreachable';
    }
  }

  //-------------------------------cloudinary-----------------------------

  static Future<List<String>> uploadImage(
      List<AssetEntity> selectedAssets) async {
    File? image;
    List<String> imagePath = [];
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dsktu4sm8/upload');
    for (int i = 0; i < selectedAssets.length; i++) {
      image = await selectedAssets[i].file;
      debugPrint(image!.path);
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'dyfsmyk5'
        ..files.add(await http.MultipartFile.fromPath('file', image.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final url = jsonMap['url'];
        imagePath.add(url);
        debugPrint(imagePath[i]);
      }
    }
    return imagePath;
  }

  //------------------------------------create post---------------------------------

  static Future<String> createPost(
      description, List<String> images, location) async {
    var client = http.Client();
    const String url = "${ApiEndPoints.baseUrl}${ApiEndPoints.createpost}";

    try {
      final String? token = await getToken();
      print(token);

      final data = {
        "postData": {
          "description": description,
          "image": images,
          "location": location
        }
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await client.post(Uri.parse(url),
          body: jsonEncode(data), headers: headers);
      debugPrint("responsebody of post:: ${response.body}");
      debugPrint("create post statuscode:${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        return "Success";
      } else {
        return "Oops";
      }
    } catch (e) {
      log(e.toString());
      return "Error";
    }
  }

  //----------------------------------------get post-----------------------------------

  static Future<List<Posts>> getPosts() async {
    final client = http.Client();
    List<Posts> list = [];
    try {
      final String? token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await client.get(
          Uri.parse("${ApiEndPoints.baseUrl}${ApiEndPoints.getPosts}"),
          headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List decodeData = jsonDecode(response.body);
        print(decodeData[0]);
        print(response.body);
        return decodeData.map((post) => Posts.fromJson(post)).toList();
      } else {
        return list;
      }
    } catch (e) {
      log(e.toString());
      print("failed");
      return list;
    }
  }

  //-------------------------------------getUser-----------------------------------

  static Future GetUser(String text) async {
    final client = http.Client();
    try {
      final String? token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await client.get(
          Uri.parse("${ApiEndPoints.baseUrl}${ApiEndPoints.search}$text"),
          headers: headers);
      print("search statuscode:${response.statusCode}");
      print("search body: ${response.body}");
      List<User> users = [];

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        List<dynamic> userList = decodedData['users'];

        for (var userData in userList) {
          User user = User.fromJson(userData);
          users.add(user);
        }
        //  return decodedData['users'].map((userData) => User.fromJson(userData)).toList();

        print('Username: ${users[0].username}');

        return users;
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
