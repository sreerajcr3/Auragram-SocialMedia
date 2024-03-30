import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/currentUser.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ApiServiceUser {
 


  //-------------------------------------SearchgetUser-----------------------------------

  static Future searchGetUser(String text) async {
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
      debugPrint("search statuscode:${response.statusCode}");
      debugPrint("search body: ${response.body}");
      List<User> users = [];

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        List<dynamic> userList = decodedData['users'];

        for (var userData in userList) {
          User user = User.fromJson(userData);
          users.add(user);
        }
        //  return decodedData['users'].map((userData) => User.fromJson(userData)).toList();

        debugPrint('Username: ${users[0].username}');

        return users;
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  //--------------------------------------CurrentUser   Profile-------------------------------------

  static Future<CurrentUser?> currentUser() async {
    final client = http.Client();
    try {
      final String? token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.currentUser}";
      final response = await client.get(Uri.parse(url), headers: headers);
      debugPrint("currentUserrequestbody = ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        final userData = decodedData['user'];
        final currentUserPosts = decodedData['posts'];
        final user = User.fromJson(userData);
        final List<Posts> posts = [];
        for (var element in currentUserPosts) {
          posts.add(Posts.fromJson(element));
        }
        return CurrentUser(user: user, posts: posts);
      } else {
        return null;
      }
    } catch (e) {
      log('error $e');
      return null;
    }
  }
 
}