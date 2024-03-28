part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeState {}

final class LikeUnlikeInitial extends LikeUnlikeState {}
final class LikeSuccessState extends LikeUnlikeState {}
