part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostState {}

final class CreatePostInitial extends CreatePostState {}

final class CreatePostSuccessState extends CreatePostState {}

final class CreatePostErrorState extends CreatePostState {}

final class CreatePostOopsState extends CreatePostState {}

final class CreatePostLoadingState extends CreatePostState {}
