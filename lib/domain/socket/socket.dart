import 'dart:convert';
import 'dart:developer';

import 'package:aura/bloc/chat/bloc/chat_bloc.dart';
import 'package:aura/domain/model/chat_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  io.Socket socket = io.io(
    'https://connect-lz92.onrender.com',
    io.OptionBuilder().setTransports(['websocket']).build(),
  );
  void connectSocket(BuildContext buildContext) async {
    final username = await getUsername();
    if (socket.disconnected) {
      socket.connect();
    }
    socket.onConnect((data) {
      debugPrint('Connection established');
    });
    socket.off("message");
    socket.on("message", (data) {
      try {
        // conversations.add(Chat.fromJson(data));
      } catch (e) {
        log(e.toString());
      }

      debugPrint('inside get  message-$data');
      debugPrint('inside get message - ${data['message']}');
      debugPrint('Sender username - ${data['sender']['username']}');
      debugPrint('Receiver username - ${data['receiver']['username']}');

      final chat = Chat(
          id: '',
          sender: User(
              username: data['sender']['username'], id: data['sender']['_id']),
          receiver: User(
              username: data['receiver']['username'],
              id: data['receiver']['_id']),
          message: data['message'],
          createdAt: data['createdAt'],
          updatedAt: '');

          buildContext.read<ChatBloc>().add(AddReceivedChatEvent(chat: chat));


    });
    socket.onConnectError((data) => debugPrint('connect error:$data'));
    socket.onDisconnect((data) => debugPrint('Socket.IO server disconnected'));

    socket.emit("newUser", username);
  }

  sendMessage(
      {required String loginUsername,
      required String logineduserid,
      required String recieverid,
      required String recievername,
      required String message}) {
    final body = {
      "message": message,
      "sender": {"username": loginUsername, "_id": logineduserid},
      "receiver": {"username": recievername, "_id": recieverid}
    };
    socket.emit("message", jsonEncode(body));
  }

  disconnectSocket() {
    socket.disconnect();
    socket.clearListeners();
  }
}
