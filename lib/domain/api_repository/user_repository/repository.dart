import 'dart:convert';
import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/current_user.dart';
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
      debugPrint("succusful state profile");

        final decodedData = jsonDecode(response.body);
        final userData = decodedData['user'];
        final currentUserPosts = decodedData['posts'];

        final user = User.fromJson(userData);

        final List<Posts> posts = [];
        for (var element in currentUserPosts) {
          posts.add(Posts.fromJson(element));
        }

        final List followingUserIds = [];
        for (var followingUser in user.following!) {
          followingUserIds.add(followingUser['_id']);
        }

        final List<User> followersUsers = [];
        for (var user in user.followers!) {
          followersUsers.add(User.fromJson(user));
        }

       
        final List followingUsersNames = [];
        for (var user in user.following!) {
          followingUsersNames.add(User.fromJson(user));
        }
        // final List followersUserslist = [];
        // for (var followingUser in user.following!) {
        //   followersUserslist.add(followingUser['username']);
        // }
        // print("followers list === $followingUsersNames");
        // print("followers list === $followersUserslist");
        return CurrentUser(
            user: user,
            posts: posts,
            followingIdsList: followingUserIds,
            followingUsersList: followingUsersNames,
            followersUsersList: followersUsers);
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

        final List<User> followingUsers = [];
        for (var user in user.following!) {
          followingUsers.add(User.fromJson(user));
        }
        final List<User> followersUsers = [];
        for (var user in user.followers!) {
          followersUsers.add(User.fromJson(user));
        }
 
        return GetUserModel(
          user: user,
          posts: posts,
          followingUsersList: followingUsers,
          followersUsersList: followersUsers,
        );
      } else {
        return null;
      }
    } catch (e) {
      log('error $e');
      return null;
    }
  }


  //######################################## get all users ##########################

static  getAllUsers()async{

  final client = http.Client();
  const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.getAllUsers}";

   final String? token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      List allUsers = [];

      try {
        final response =await client.get(Uri.parse(url),headers: headers);
        debugPrint("response body getAllUsers = ${response.body}");
        final responseBody = jsonDecode(response.body);
      final result =  responseBody['user'];
      print("result = $result");
        if (response.statusCode == 200 || response.statusCode == 201) {
          for (var user in result) {
            allUsers.add(User.fromJson(user));
          }
          return allUsers;
        }
      } catch (e) {
        log(e.toString());
      }

}

}
