import 'dart:async';

import 'package:aura/domain/api_repository/chat/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'message_list_event.dart';
part 'message_list_state.dart';

class MessageListBloc extends Bloc<MessageListEvent, MessageListState> {
  MessageListBloc() : super(MessageListInitial()) {
    on<GetUsersFromChat>(getUsersFromChat);
  }

  FutureOr<void> getUsersFromChat(GetUsersFromChat event, Emitter<MessageListState> emit)async {
    final List result = await ApiServiceChat.getUsersInChat();
   if (result .isNotEmpty){
    emit(UsersListFromChatSuccefullState(usersList: result));
   }
  }
}
