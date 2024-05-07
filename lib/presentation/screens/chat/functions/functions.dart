  import 'package:aura/bloc/all_mesages/bloc/all_messages_bloc.dart';
import 'package:aura/bloc/message_list.dart/bloc/message_list_bloc.dart';
import 'package:aura/domain/model/last_message_details.dart';

 getLastMessage(String userId, List<dynamic> data) {
    for (var chatData in data.reversed) {
      var senderId = chatData.sender.id;
      var receiverId = chatData.receiver.id;
      if (senderId == userId || receiverId == userId) {
        return LastMessageModel(lastMessage: chatData.message, lastmessageTime: chatData.createdAt);
      }
    }
    return null; // Return null if no matching message is found
  }
     Future<void> refreshmessageList(context) async {
    await Future.delayed(const Duration(seconds: 2));
       context.read<MessageListBloc>().add(GetUsersFromChat());
    context.read<AllMessagesBloc>().add(GetAllChatWithMeEvent());
  }