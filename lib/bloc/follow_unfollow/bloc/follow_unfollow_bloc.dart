import 'dart:async';

import 'package:aura/domain/api_repository/follow_unfollow_repository/follow_unfollow_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'follow_unfollow_event.dart';
part 'follow_unfollow_state.dart';

class FollowUnfollowBloc
    extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  FollowUnfollowBloc() : super(FollowUnfollowInitial()) {
    on<TofollowEvent>(tofollowEvent);
    on<ToUnfollowEvent>(toUnfollowEvent);
     emit(FollowUpdatedState());
  }

  FutureOr<void> tofollowEvent(
      TofollowEvent event, Emitter<FollowUnfollowState> emit) async {
    final result = await ApiServiceFollowUnfollow.follow(event.userId);
    if (result) {
      emit(FollowUpdatedState());
    } else {
      emit(FollowUpdatedState());
    }
  }

  FutureOr<void> toUnfollowEvent(
      ToUnfollowEvent event, Emitter<FollowUnfollowState> emit) async {
    final result = await ApiServiceFollowUnfollow.unfollow(event.userId);
    if (result) {
      emit(FollowUpdatedState());
    } else {
      emit(FollowUpdatedState());
    }
  }
}
