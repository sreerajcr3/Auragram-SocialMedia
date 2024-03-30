part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

class CommentSuccessState extends CommentState {}

class CommentFailedState extends CommentState {}

class CommentErrorState extends CommentState {}

class CommentUpdateState extends CommentState {}

class CommentDeleteSuccessState extends CommentState {}

class CommentDeleteErrorState extends CommentState {}
