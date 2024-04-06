import 'dart:convert';
import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/currentUser.dart';
import 'package:aura/domain/model/get_user_model.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

        final List followingUserIds = [];
        for (var followingUser in user.followers!) {
          followingUserIds.add(followingUser['_id']);
        }
        return CurrentUser(user: user, posts: posts,followingIdsList: followingUserIds);
      } else {
        return null;
      }
    } catch (e) {
      log('error $e');
      return null;
    }
  }

  //-------------------------------------------------get user ----------------------------------------------
  static Future<GetUserModel?> getUser(userid) async {
    final client = http.Client();
    try {
      final String? token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.getUser}$userid";
      final response = await client.get(Uri.parse(url), headers: headers);

      debugPrint("getuserrequestbody = ${response.body}");
      debugPrint("getuserstatuscode = ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        final userData = decodedData['user'];
        final currentUserPosts = decodedData['posts'];
        final user = User.fromJson(userData);

        final List<Posts> posts = [];
        for (var element in currentUserPosts) {
          posts.add(Posts.fromJson(element));
        }
        return GetUserModel(user: user, posts: posts);
      } else {
        return null;
      }
    } catch (e) {
      log('error $e');
      return null;
    }
  }

  //###################################   extracting the id list of following from the current user        ###########################################

  static Future getFollowingList() async {
    final client = http.Client();

    try {
      final String? token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.currentUser}";
      final response = await client.get(Uri.parse(url), headers: headers);
      final decodedData = jsonDecode(response.body);
      final userData = decodedData['user'];
      final user = User.fromJson(userData);

      final List followingUserIds = [];
      for (var followingUser in user.following!) {
        followingUserIds.add(followingUser['_id']);
      }
      print("user.following = ${followingUserIds}");
      return followingUserIds;
    } catch (e) {
      log(e.toString());
    }
  }
}
