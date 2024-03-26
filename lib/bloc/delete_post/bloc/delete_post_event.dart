part of 'delete_post_bloc.dart';

@immutable
sealed class DeletePostEvent {}

class DeleteEvent extends DeletePostEvent{
  final String id;

  DeleteEvent({required this.id});
}
