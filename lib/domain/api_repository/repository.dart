import 'dart:convert';
import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}
