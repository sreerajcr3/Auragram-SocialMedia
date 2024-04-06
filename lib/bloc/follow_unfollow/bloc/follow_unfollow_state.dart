part of 'follow_unfollow_bloc.dart';

@immutable
sealed class FollowUnfollowState {}

final class FollowUnfollowInitial extends FollowUnfollowState {}
final class FollowUpdatedState extends FollowUnfollowState {}

final class FollowSuccesssFullState extends FollowUnfollowState {}

final class FollowfailedFullState extends FollowUnfollowState {}

final class UnFollowSuccesssFullState extends FollowUnfollowState {}

final class UnFollowfailedFFullState extends FollowUnfollowState {}
