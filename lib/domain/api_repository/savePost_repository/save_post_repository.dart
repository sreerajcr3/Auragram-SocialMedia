import 'dart:convert';
import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/post_model.dart';
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

  static Future<SavedPosts?> getSavedPost() async {
    const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.savedPost}";

    final String? token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await client.get(Uri.parse(url), headers: headers);
      final responseBody = jsonDecode(response.body);
      print('response body<<<<<<<<<<<<<<$responseBody');
        final List<dynamic> postsList = responseBody['saved-posts']['posts'];
print("postlist----$postsList");
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
      
      final List<Posts> posts = [];
      for (var element in postsList) {
        posts.add(Posts.fromJson(element));
      }
      return SavedPosts(posts: posts);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
