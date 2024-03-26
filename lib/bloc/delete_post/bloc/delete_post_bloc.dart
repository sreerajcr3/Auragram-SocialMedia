import 'dart:async';

import 'package:aura/domain/api_repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_post_event.dart';
part 'delete_post_state.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  DeletePostBloc() : super(DeletePostInitial()) {
    on<DeleteEvent>(deleteEvent);
  }

  FutureOr<void> deleteEvent(DeleteEvent event, Emitter<DeletePostState> emit)async {
    final result =await ApiService.deletePost(event.id);
    if (result) {
      emit(DeletePostSuccessState());
    }else{
      emit(DeletePostError());
    }

  }
}
