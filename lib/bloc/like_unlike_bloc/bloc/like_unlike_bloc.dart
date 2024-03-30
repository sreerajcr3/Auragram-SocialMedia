import 'dart:async';

import 'package:aura/domain/api_repository/like_repository/like_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  LikeUnlikeBloc() : super(LikeUnlikeInitial()) {
    on<LikeAddEvent>(likeAddEvent);
    on<UnlikeEvent>(unlikeEvent);
    // on<LikeCountState>(likeCountState);
    emit(LikeCountUpdatedState());
  }

  FutureOr<void> likeAddEvent(LikeAddEvent event, Emitter<LikeUnlikeState> emit)async {
   final result =await ApiServiceLikeUnlike.like(event.id);
   if (result) {
     emit(LikeSuccessState());
     emit(LikeCountUpdatedState());
       debugPrint("like");
   }
  }

  FutureOr<void> unlikeEvent(UnlikeEvent event, Emitter<LikeUnlikeState> emit)async {
    final result =await ApiServiceLikeUnlike.unlike(event.id);
    if (result) {
     emit(UnlikeSuccessState());
     emit(LikeCountUpdatedState());
     debugPrint("unlike");
   }
  }

  // FutureOr<void> likeCountState(LikeCountState event, Emitter<LikeUnlikeState> emit) {
  //   int likeCount = 0;
  //   if (event is LikeAddEvent) {
  //     likeCount++;
  //     emit(LikeCountUpdatedState(likeCount));
  //   } else if(event is UnlikeEvent){
  //     likeCount--;
  //     emit(LikeCountUpdatedState(likeCount));
  //   }
  // }
}
