part of 'missions_cubit.dart';

@immutable
sealed class MissionsState {}

final class MissionsInitial extends MissionsState {}

final class MissionsLoading extends MissionsState {}

final class MissionsSuccess extends MissionsState {
  final TaskResponseModel missions;

  MissionsSuccess(this.missions);
}

final class MissionsError extends MissionsState {
  final String message;

  MissionsError(this.message);
}
