part of 'all_messages_bloc.dart';

@immutable
sealed class AllMessagesState {}

final class AllMessagesInitial extends AllMessagesState {}
final class GetAllChatWithMeSuccessState extends AllMessagesState {
  final List chat;

  GetAllChatWithMeSuccessState({required this.chat});
}



