import 'dart:async';

import 'package:aura/domain/api_repository/uset_repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<GetUserEvent>(getUserEvent);
  }

  FutureOr<void> getUserEvent(
      GetUserEvent event, Emitter<SearchState> emit) async {
    final result = await ApiServiceUser.searchGetUser(event.text);
    if (result.isNotEmpty) {
      emit(SearchSuccessState(usersList: result));
    } else {
      emit(SearchErrorState());
    }
  }
}
