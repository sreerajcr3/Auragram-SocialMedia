import 'dart:convert';
import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/model/chat_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServiceChat {
  static var client = http.Client();

  static getAllChat() async {
    List list = [];
    const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.getAllChat}";
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await client.get(Uri.parse(url), headers: headers);
    debugPrint("response body chat = ${response.body}");
    debugPrint("chat statusdcode = ${response.statusCode}");
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responsebody = jsonDecode(response.body);
        for (var chat in responsebody) {
          list.add(Chat.fromJson(chat));
        }
        return list;
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  static getChatWithUser(String userID) async {
    List list = [];
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.getChatWithUser}$userID";
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await client.get(Uri.parse(url), headers: headers);
    debugPrint("response body getChatwithuser = ${response.body}");
    debugPrint("getChatwithuser statusdcode = ${response.statusCode}");
    try {
      if (response.statusCode == 200) {
        print("chat with user = $list");
        final responsebody = jsonDecode(response.body)['data'];
        for (var chat in responsebody) {
          list.add(Chat.fromJson(chat));
        }
        print("chat with user after= $list");

        return list;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<List<User>> getUsersInChat() async {
    List<User> userList = [];
    const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.getChatWithUser}";
    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await client.get(Uri.parse(url), headers: headers);
    debugPrint("response body get users in chat = ${response.body}");
    debugPrint("get users in chat statusdcode = ${response.statusCode}");
    final username = await getUsername();

    try {
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
           for (var chatData in data) {
        String senderUsername = chatData['sender']['username'];
        String receiverUsername  = chatData['receiver']['username'];
        
        if (senderUsername != username && !userList.any((user) => user.username == senderUsername)) {
          userList.add(User.fromJson(chatData['sender']));
        }
        if (receiverUsername != username && !userList.any((user) => user.username == receiverUsername)) {
          userList.add(User.fromJson(chatData['receiver']));
        }
      }
        return userList;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
