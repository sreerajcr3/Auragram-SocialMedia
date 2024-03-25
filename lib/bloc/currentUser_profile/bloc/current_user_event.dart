part of 'current_user_bloc.dart';

@immutable
sealed class CurrentUserEvent {}

class CurrentUserFetchEvent extends CurrentUserEvent {
  
}
