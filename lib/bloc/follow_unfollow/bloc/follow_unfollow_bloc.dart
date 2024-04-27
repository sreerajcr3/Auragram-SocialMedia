import 'dart:async';

import 'package:aura/domain/api_repository/follow_unfollow_repository/follow_unfollow_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'follow_unfollow_event.dart';
part 'follow_unfollow_state.dart';

class FollowUnfollowBloc
    extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  FollowUnfollowBloc() : super(FollowUnfollowInitial()) {
    on<TofollowEvent>(tofollowEvent);
    on<ToUnfollowEvent>(toUnfollowEvent);
    on<FollowUpdateEvent>(followUpdateEvent);

    //  emit(FollowUnfollowInitial());
  }

  FutureOr<void> tofollowEvent(
      TofollowEvent event, Emitter<FollowUnfollowState> emit) async {
    final result = await ApiServiceFollowUnfollow.follow(event.userId);
    if (result) {
      emit(FollowSuccesssFullState());
    } else {
      // emit(FollowUpdatedState());
    }
  }

  FutureOr<void> toUnfollowEvent(
      ToUnfollowEvent event, Emitter<FollowUnfollowState> emit) async {
    final result = await ApiServiceFollowUnfollow.unfollow(event.userId);
    if (result) {
      emit(UnFollowSuccesssFullState());

    } else {
      // emit(FollowUpdatedState());
    }
  }

  FutureOr<void> followUpdateEvent(
      FollowUpdateEvent event, Emitter<FollowUnfollowState> emit) {
        print("follow bloc worked");
    emit(FollowUpdatedState());
    // Timer(Duration(seconds: 2), () {
    //   emit(FollowfailedFullState());
    // });
  }
}
