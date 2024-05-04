part of 'get_user_bloc.dart';

@immutable
sealed class GetUserState {}

final class GetUserInitial extends GetUserState {}

final class GetUsersuccessState extends GetUserState {
  final GetUserModel getUserModel;

  GetUsersuccessState({required this.getUserModel});
}

final class GetUserLoading extends GetUserState {}

final class GetAllUsersSuccessState extends GetUserState {
  final List allUsers;

  GetAllUsersSuccessState({required this.allUsers});
}
