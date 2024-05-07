part of 'all_messages_bloc.dart';

@immutable
sealed class AllMessagesEvent {}

final class GetAllChatWithMeEvent extends AllMessagesEvent {}
