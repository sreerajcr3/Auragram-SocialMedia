part of 'bool_bloc.dart';

@immutable
sealed class BoolEvent {}
class SetBool extends BoolEvent {
  final bool value;

  SetBool({required this.value});
}
