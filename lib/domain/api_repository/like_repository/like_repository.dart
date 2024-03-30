import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServiceLikeUnlike {
  static var client = http.Client();

  static Future<bool> like(id) async {
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.like}$id";

    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.patch(Uri.parse(url), headers: headers);
      debugPrint("likeSUccess State = ${response.statusCode}");
      debugPrint("like body:${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> unlike(id) async {
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.unlike}$id";

    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.patch(Uri.parse(url), headers: headers);
      debugPrint("unlike State = ${response.statusCode}");
      debugPrint("unlike body:${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
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
