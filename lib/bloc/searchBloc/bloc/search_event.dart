part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class GetUserEvent extends SearchEvent{
  final String text;

  GetUserEvent({required this.text});

 
}
