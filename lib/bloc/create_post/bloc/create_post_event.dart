part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostEvent {}

class Createpost extends CreatePostEvent {
  final List<String> images;
  final String description;
  final String location;


  Createpost({required this.images, required this.description, required this.location});}


