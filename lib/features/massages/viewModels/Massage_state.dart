part of 'Massage_cubit.dart';

@immutable
sealed class MassageState {}

final class MassageInitial extends MassageState {}

final class MassageLoading extends MassageState {}

final class MassageSuccess extends MassageState {
  final MassageResponseModel messages;

  MassageSuccess(this.messages);
}

final class MassageError extends MassageState {
  final String message;

  MassageError(this.message);
}
