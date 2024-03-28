import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:http/http.dart' as http;

class ApiServicesPost {
  static var client = http.Client();

  //-------------------------------cloudinary-----------------------------

  static Future<List<String>> uploadImage(
      List<AssetEntity> selectedAssets) async {
    File? image;
    List<String> imagePath = [];
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dsktu4sm8/upload');
    for (int i = 0; i < selectedAssets.length; i++) {
      image = await selectedAssets[i].file;
      debugPrint(image!.path);
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'dyfsmyk5'
        ..files.add(await http.MultipartFile.fromPath('file', image.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final url = jsonMap['url'];
        imagePath.add(url);
        debugPrint(imagePath[i]);
      }
    }
    return imagePath;
  }

  //------------------------------------create post---------------------------------

  static Future<String> createPost(
      description, List<String> images, location) async {
    const String url = "${ApiEndPoints.baseUrl}${ApiEndPoints.createpost}";

    try {
      final String? token = await getToken();
      debugPrint(token);

      final data = {
        "postData": {
          "description": description,
          "image": images,
          "location": location
        }
      };
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await client.post(Uri.parse(url),
          body: jsonEncode(data), headers: headers);
      debugPrint("responsebody of post:: ${response.body}");
      debugPrint("create post statuscode:${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        return "Success";
      } else {
        return "Oops";
      }
    } catch (e) {
      log(e.toString());
      return "Error";
    }
  }

  //----------------------------------------get post-----------------------------------

  static Future<List<Posts>> getPosts() async {
    List<Posts> list = [];
    try {
      final String? token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await client.get(
          Uri.parse("${ApiEndPoints.baseUrl}${ApiEndPoints.getPosts}"),
          headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List decodeData = jsonDecode(response.body);
        debugPrint(response.body);
        return decodeData.map((post) => Posts.fromJson(post)).toList();
      } else {
        return list;
      }
    } catch (e) {
      log(e.toString());
      debugPrint("failed");
      return list;
    }
  }

   //------------------------------------------delete post-----------------------------------

  static Future<bool> deletePost(String id) async {
    final client = http.Client();
    try {
      final String? token = await getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final url = ("${ApiEndPoints.baseUrl}${ApiEndPoints.delete}$id");
      final response = await client.delete(Uri.parse(url), headers: headers);
      debugPrint("delete Status code = ${response.statusCode}");
      debugPrint(response.body);
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
