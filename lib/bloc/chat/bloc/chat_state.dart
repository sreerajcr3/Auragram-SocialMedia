part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatUpdateState extends ChatState {}
final class ChatLoadingState extends ChatState {}
final class GetChatSuccefullState extends ChatState {
  final List chat;

  GetChatSuccefullState({required this.chat});
}
final class ChatWithCurrentUserState extends ChatState{
  final List users;

  ChatWithCurrentUserState({required this.users});
}

 
