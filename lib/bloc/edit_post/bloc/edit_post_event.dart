part of 'edit_post_bloc.dart';

@immutable
sealed class EditPostEvent {}

class PostEditEvent extends EditPostEvent{
  final String postId;
  final String description;
  final String location;

  PostEditEvent({required this.description, required this.location,required this.postId, });
}
