import 'dart:async';

import 'package:aura/domain/api_repository/post_repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'delete_post_event.dart';
part 'delete_post_state.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  DeletePostBloc() : super(DeletePostInitial()) {
    on<DeleteEvent>(deleteEvent);
  }

  FutureOr<void> deleteEvent(DeleteEvent event, Emitter<DeletePostState> emit)async {
    final result =await ApiServicesPost.deletePost(event.id);
    if (result) {
      emit(DeletePostSuccessState());
    }else{
      emit(DeletePostError());
    }

  }
}
