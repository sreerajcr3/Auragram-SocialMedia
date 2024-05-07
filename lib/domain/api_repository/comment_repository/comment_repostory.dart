import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServiceComment {
  static var client = http.Client();

  //--------------------------add commment--------------------------

  static Future<String> addComment(postId, comment) async {
    const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.addcomment}";

    final String? token = await getToken();
    final data = {"postId": postId, "comment": comment};
    final headers = {'Authorization': 'Bearer $token'};
    try {
      final response =
          await client.post(Uri.parse(url), body: data, headers: headers);
      print(response.body);
      print("add comment statuscode = ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'success';
      } else if (response.statusCode == 404) {
        return 'failed';
      } else {
        return '';
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  //------------------------------------delete comment-----------------------------

  static Future<bool> deleteComment(postId,commentId) async {

    // const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.deletecomment}";

     final String? token = await getToken();
    final data = {"postId": postId, "commentId": commentId};
    final headers = {'Authorization': 'Bearer $token'};
    const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.deletecomment}";
    final response = await client.post(Uri.parse(url),body: data,headers: headers);
    debugPrint("delete comment statuscode=${response.statusCode}");
    debugPrint("delete comment response body=${response.body}");
    try {
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
