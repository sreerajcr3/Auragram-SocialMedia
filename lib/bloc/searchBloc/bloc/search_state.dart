part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchSuccessState extends SearchState {
  final List usersList;

  SearchSuccessState({required this.usersList});
}
class SearchErrorState extends SearchState {
  
}
class SearchNoUserState extends SearchState {
  
}
