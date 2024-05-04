import 'dart:convert';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/chat_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServiceChat {
  static var client = http.Client();

  static getAllChat()async{
    List list = [];
    const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.getAllChat}";
    final token = await getToken();
     final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response =await client.get(Uri.parse(url),headers:headers );
    debugPrint("response body chat = ${response.body}");
    debugPrint("chat statusdcode = ${response.statusCode}");
    try {
if (response.statusCode == 200 ||response.statusCode == 201) {
  final responsebody = jsonDecode(response.body);
  for (var chat in responsebody) {
    list.add(Chat.fromJson(chat));
  }
  return list;
} else {
  
}
    } catch (e) {
      
    }
  }
}