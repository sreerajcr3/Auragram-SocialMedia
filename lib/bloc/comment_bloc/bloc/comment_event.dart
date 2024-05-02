part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class AddCommentEvent extends CommentEvent {
  final String postId;
  final String comment;

  AddCommentEvent({required this.postId, required this.comment});

}
class DeleteCommentEvent extends CommentEvent {
   final String postId;
  final String commentId;

  DeleteCommentEvent({required this.postId, required this.commentId});
}
class CommentUpdateEvent extends CommentEvent {

  CommentUpdateEvent();
}
