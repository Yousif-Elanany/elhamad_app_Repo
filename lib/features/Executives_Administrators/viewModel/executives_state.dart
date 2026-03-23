import '../Models/ExecutivesResponseModel.dart';

abstract class ExecutivesState {}

class ExecutivesInitial extends ExecutivesState {}

class ExecutivesLoading extends ExecutivesState {}

class ExecutivesSuccess extends ExecutivesState {
  final ExecutivesResponseModel data;

  ExecutivesSuccess(this.data);
}

class ExecutivesError extends ExecutivesState {
  final String message;

  ExecutivesError(this.message);
}
