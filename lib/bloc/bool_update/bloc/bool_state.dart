part of 'bool_bloc.dart';

@immutable
sealed class BoolState {}

final class BoolInitial extends BoolState {}
final class BoolTrue extends BoolState{}
final class BoolFalse extends BoolState{}
final class BoolUpdate extends BoolState{
  final bool value;

  BoolUpdate({required this.value});
}
