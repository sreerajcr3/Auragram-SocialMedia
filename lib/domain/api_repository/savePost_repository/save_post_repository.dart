import 'dart:convert';
import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/saved_post.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiServiceSavePost {
  static final client = http.Client();

  static Future<bool> savePost(postId) async {
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.savePost}$postId";

    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await client.post(Uri.parse(url), headers: headers);
    debugPrint("savepost statuscode = ${response.statusCode}");
    debugPrint("response body = ${response.body}");

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

  static Future<bool> unSavePost(postId) async {
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.unSavePost}$postId";
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await client.patch(Uri.parse(url), headers: headers);
    debugPrint("unsavepost statuscode = ${response.statusCode}");
    debugPrint("response body = ${response.body}");

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

 static Future<SavedPosts?> getSavedPost() async {
  try {
    const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.savedPost}";
    final String? token = await getToken();
    debugPrint("token-----$token");
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await client.get(Uri.parse(url), headers: headers);

    debugPrint("saved post statuscode = ${response.statusCode}");
    debugPrint("saved post status code = ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      debugPrint("saved post response body $responseBody");
    final savedPosts = SavedPosts.fromJson(responseBody['saved-posts']);

      return savedPosts;
      
    } else {
      debugPrint("Failed to fetch saved posts. Status code: ${response.statusCode}");
      return null; 
    }
  } catch (e) {
    debugPrint("Error fetching saved posts: $e");
    return null; 
  }
}


 
}
