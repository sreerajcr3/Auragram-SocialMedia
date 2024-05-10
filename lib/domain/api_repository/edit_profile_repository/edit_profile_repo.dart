import 'dart:convert';
import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/api_repository/post_repository/post_repository.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServiceEditProfile {
  static var client = http.Client();

  static editprofile(String username, String fullname, String? bio, profilePic,
      coverpic) async {
    final dynamic profilePicUrl;
    final dynamic coverPicUrl;
    


    if (profilePic is! String) {
      profilePicUrl = await ApiServicesPost.uploadProfilePicture(profilePic);
    } else {
      profilePicUrl = profilePic;
    }
    if (coverpic is !String) {
        coverPicUrl = await ApiServicesPost.uploadProfilePicture(coverpic);
    } else {
      coverPicUrl = coverpic;
    }
   
    debugPrint("coverpic url = $coverPicUrl");
    debugPrint("profilePic url = $profilePicUrl");

    const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.editProfile}";
    final body = {
      
      "fullname": fullname,
      "bio": bio,
      "profile_picture": profilePicUrl,
      "cover_photo": coverPicUrl
    };
    final encodedbody = jsonEncode(body);
    final token =await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response =
          await client.patch(Uri.parse(url), body: encodedbody, headers: headers);
      debugPrint("response statuscode = ${response.statusCode}");
      debugPrint("response body = ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
