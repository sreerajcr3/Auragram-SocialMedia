part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

class PostSuccessState extends PostsState {
  final List<Posts> posts;

  PostSuccessState({required this.posts});
}
class PostErrorState extends PostsState {
  
}
class PostLoadingState extends PostsState {
  
}
class PostUpdatedState extends PostsState {
  
}
