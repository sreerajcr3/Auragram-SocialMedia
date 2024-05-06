part of 'message_list_bloc.dart';

@immutable
sealed class MessageListEvent {}
final class GetUsersFromChat extends MessageListEvent{}
