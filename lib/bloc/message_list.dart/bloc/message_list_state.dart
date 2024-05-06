part of 'message_list_bloc.dart';

@immutable
sealed class MessageListState {}

final class MessageListInitial extends MessageListState {}

final class UsersListFromChatSuccefullState extends MessageListState{
  final List usersList;

  UsersListFromChatSuccefullState({required this.usersList});
}
