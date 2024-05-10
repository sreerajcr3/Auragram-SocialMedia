import 'dart:async';

import 'package:aura/domain/api_repository/chat/chat_repo.dart';
import 'package:aura/domain/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List messageList = [];
  ChatBloc() : super(ChatInitial()) {
    // on<ChatUpdateEvent>(chatUpdateEvent);
    on<AddReceivedChatEvent>(addReceivedChatEvent);
    on<ChatWithUserEvent>(chatWithUserEvent);
    on<GetMyChatEvent>(getMyChatEvent);
   
  }

  FutureOr<void> chatUpdateEvent(
      ChatUpdateEvent event, Emitter<ChatState> emit) {
    emit(ChatUpdateState());
  }

  FutureOr<void> addReceivedChatEvent(
      AddReceivedChatEvent event, Emitter<ChatState> emit) async {
    messageList.add(event.chat);
    messageList.sort(((a, b) => a.createdAt.compareTo(b.createdAt)));
    emit(GetChatSuccefullState(chat: messageList));
  }

  FutureOr<void> chatWithUserEvent(
      ChatWithUserEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    final List result = await ApiServiceChat.getChatWithUser(event.userId);
    debugPrint("chat = $result");
    messageList = result;
    messageList.sort(((a, b) => a.createdAt.compareTo(b.createdAt)));
    emit(GetChatSuccefullState(chat: messageList));
    if (result.isEmpty) {
      emit(GetChatSuccefullState(chat: result));
    }
  }


  FutureOr<void> getMyChatEvent(GetMyChatEvent event, Emitter<ChatState> emit) async {
   final List result = await ApiServiceChat.getUsersInChat();
   if (result .isNotEmpty){
    emit(ChatWithCurrentUserState(users: result));
   }
  }

 
}
