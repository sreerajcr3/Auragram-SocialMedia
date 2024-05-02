

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'explore_page_state.dart';

class ExplorePageCubit extends Cubit<bool> {
  ExplorePageCubit() : super(false);

  void pageChange(bool isTapped){
    emit(isTapped);
  }
}
