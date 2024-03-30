part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeState {}

final class LikeUnlikeInitial extends LikeUnlikeState {}

final class LikeSuccessState extends LikeUnlikeState {}

final class UnlikeSuccessState extends LikeUnlikeState {}

class LikeCountUpdatedState extends LikeUnlikeState {}
