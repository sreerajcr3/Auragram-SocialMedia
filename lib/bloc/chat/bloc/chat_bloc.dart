import 'dart:async';

import 'package:aura/domain/model/chat_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List messageList = [];
  ChatBloc() : super(ChatInitial()) {
    // on<ChatUpdateEvent>(chatUpdateEvent);
    on<AddReceivedChatEvent>(addReceivedChatEvent);
  }

  FutureOr<void> chatUpdateEvent(ChatUpdateEvent event, Emitter<ChatState> emit) {
    emit(ChatUpdateState());
  }

  FutureOr<void> addReceivedChatEvent(AddReceivedChatEvent event, Emitter<ChatState> emit)async {
    messageList.add(event.chat);
    emit(GetChatSuccefullState(chat: messageList));
  }
}
