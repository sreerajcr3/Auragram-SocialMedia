import 'dart:async';

import 'package:aura/core/urls/url.dart';
import 'package:aura/domain/api_repository/like_repository/like_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  LikeUnlikeBloc() : super(LikeUnlikeInitial()) {
    on<LikeAddEvent>(likeAddEvent);
    on<UnlikeEvent>(unlikeEvent);
  }

  FutureOr<void> likeAddEvent(LikeAddEvent event, Emitter<LikeUnlikeState> emit) {
   final result = ApiServiceLikeUnlike.like(event.id);
  }

  FutureOr<void> unlikeEvent(UnlikeEvent event, Emitter<LikeUnlikeState> emit) {
    final result = ApiServiceLikeUnlike.unlike(event.id);
  }
}
