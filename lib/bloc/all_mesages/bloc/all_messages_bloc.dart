import 'dart:async';

import 'package:aura/domain/api_repository/chat/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_messages_event.dart';
part 'all_messages_state.dart';

class AllMessagesBloc extends Bloc<AllMessagesEvent, AllMessagesState> {
  AllMessagesBloc() : super(AllMessagesInitial()) {
    on<GetAllChatWithMeEvent>(getAllChatWithMeEvent);
  }

  FutureOr<void> getAllChatWithMeEvent(GetAllChatWithMeEvent event, Emitter<AllMessagesState> emit)async {
    final result = await ApiServiceChat.getAllChatWithMe();
    if (result.isNotEmpty) {
      
      emit(GetAllChatWithMeSuccessState(chat: result));
    }else{
      debugPrint("getAllChatWithMeEvent failed");
    }
  }
  }

