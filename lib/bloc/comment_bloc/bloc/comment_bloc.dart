import 'dart:async';

import 'package:aura/domain/api_repository/comment_repository/comment_repostory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<AddCommentEvent>(addCommentEvent);
    on<DeleteCommentEvent>(deleteCommentEvent);
    on<CommentUpdateEvent>(commentUpdateEvent);
    // emit(CommentUpdateState());
  }

  FutureOr<void> addCommentEvent(
      AddCommentEvent event, Emitter<CommentState> emit) async {
    final result =
        await ApiServiceComment.addComment(event.postId, event.comment);
    if (result == 'success') {
      debugPrint('update worked');
      emit(CommentSuccessState());
      // emit(CommentUpdateState());
    } else if (result == 'failed') {
      // emit(CommentFailedState());
      emit(CommentUpdateState());
    } else {
      emit(CommentErrorState());
      emit(CommentUpdateState());
    }
  }

  FutureOr<void> deleteCommentEvent(
      DeleteCommentEvent event, Emitter<CommentState> emit) async {
    final result =
        await ApiServiceComment.deleteComment(event.postId, event.commentId);
    if (result) {
      emit(CommentDeleteSuccessState());
      // emit(CommentUpdateState());
    } else {
      emit(CommentDeleteErrorState());
      // emit(CommentUpdateState());
    }
  }


  FutureOr<void> commentUpdateEvent(CommentUpdateEvent event, Emitter<CommentState> emit) {
    emit(CommentUpdateState());
  }
}
