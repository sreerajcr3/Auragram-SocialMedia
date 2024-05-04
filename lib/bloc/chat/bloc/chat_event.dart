part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}
final class ChatUpdateEvent extends ChatEvent{}


final class AddReceivedChatEvent extends ChatEvent{
  final Chat chat;

  AddReceivedChatEvent({required this.chat});
}


