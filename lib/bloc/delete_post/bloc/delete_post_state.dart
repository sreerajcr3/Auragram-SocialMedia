part of 'delete_post_bloc.dart';

@immutable
sealed class DeletePostState {}

final class DeletePostInitial extends DeletePostState {}

final class DeletePostSuccessState extends DeletePostState {}

final class DeletePostError extends DeletePostState {}
