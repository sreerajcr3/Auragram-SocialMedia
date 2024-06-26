part of 'save_post_bloc.dart';

@immutable
sealed class SavePostEvent {}

final class ToSavePostEvent extends SavePostEvent {
  final String postId;

  ToSavePostEvent({required this.postId});
}

final class FetchsavedPostEvent extends SavePostEvent {}

final class UnsavePostEvent extends SavePostEvent {
  final String postId;

  UnsavePostEvent({required this.postId});
}
