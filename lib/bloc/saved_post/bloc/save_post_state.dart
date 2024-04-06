part of 'save_post_bloc.dart';

@immutable
sealed class SavePostState {}

final class SavePostInitial extends SavePostState {}

final class SavePostSuccessState extends SavePostState {}

final class UnSavePostSuccessState extends SavePostState {}

final class SavePostErrorState extends SavePostState {}

class FetchedSavedPostsState extends SavePostState {
  final SavedPosts savedPosts;

  FetchedSavedPostsState({ required this.savedPosts});
}
