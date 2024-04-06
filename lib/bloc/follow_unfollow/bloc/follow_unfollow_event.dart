part of 'follow_unfollow_bloc.dart';

@immutable
sealed class FollowUnfollowEvent {}

final class TofollowEvent extends FollowUnfollowEvent {
  final String userId;

  TofollowEvent({required this.userId});
}

final class ToUnfollowEvent extends FollowUnfollowEvent {
  final String userId;

  ToUnfollowEvent({required this.userId});
}
