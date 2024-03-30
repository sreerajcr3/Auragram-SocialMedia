part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeEvent {}

class LikeAddEvent extends LikeUnlikeEvent {
  final String id;

  LikeAddEvent({required this.id});
}
class UnlikeEvent extends LikeUnlikeEvent {
  final String id;

  UnlikeEvent({required this.id});
}
class LikeErrorState extends LikeUnlikeEvent {
  
}
class LikeCountState extends LikeUnlikeEvent {
  
}
