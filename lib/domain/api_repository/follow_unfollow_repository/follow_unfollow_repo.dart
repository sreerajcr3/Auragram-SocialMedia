import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServiceFollowUnfollow {
  static final client = http.Client();

  static Future<bool> follow(userId) async {
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.follow}/$userId";

    final token = await getToken();
    print("token = $token");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.patch(Uri.parse(url), headers: headers);
      debugPrint("follow response statuscode = ${response.statusCode}");
      debugPrint("follow response body = ${response.body}");
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

  static Future<bool> unfollow(userId) async {
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.unFollow}/$userId";

    final token = await getToken();
    print("token = $token");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.patch(Uri.parse(url), headers: headers);
      debugPrint("unfollow response statuscode = ${response.statusCode}");
      debugPrint("unfollow response body = ${response.body}");
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
}
