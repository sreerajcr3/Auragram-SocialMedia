import 'dart:async';

import 'package:aura/domain/api_repository/chat/chat_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
      print("failed");
    }
  }
  }

