part of 'current_user_bloc.dart';

@immutable
sealed class CurrentUserState {}

final class CurrentUserInitial extends CurrentUserState {}

final class CurrentUserSuccessState extends CurrentUserState {
  final CurrentUser currentUser;

  CurrentUserSuccessState({
    required this.currentUser,
  });
}

final class CurrentUserErrorState extends CurrentUserState {}
