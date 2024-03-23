import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'explore_page_state.dart';

class ExplorePageCubit extends Cubit<bool> {
  ExplorePageCubit() : super(false);

  void pageChange(bool isTapped){
    emit(isTapped);
  }
}
