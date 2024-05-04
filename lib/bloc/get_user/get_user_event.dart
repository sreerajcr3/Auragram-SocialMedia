part of 'get_user_bloc.dart';

@immutable
sealed class GetUserEvent {}

final class GetuserFetchEvent extends GetUserEvent {
  final String userId;

  GetuserFetchEvent({required this.userId});
}

final class GetAllUsersEvent extends GetUserEvent {}
