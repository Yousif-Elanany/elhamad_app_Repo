import '../Models/ExecutivesResponseModel.dart';
import '../Models/getExecutiveByProfileIdResponseModel.dart';

abstract class ExecutivesState {}

class ExecutivesInitial extends ExecutivesState {}

/// ===== GET ALL =====
class ExecutivesLoading extends ExecutivesState {}

class ExecutivesSuccess extends ExecutivesState {
  final ExecutivesResponseModel data;

  ExecutivesSuccess(this.data);
}

class ExecutivesError extends ExecutivesState {
  final String message;

  ExecutivesError(this.message);
}

/// ===== CREATE =====
class CreateExecutiveLoading extends ExecutivesState {}

class CreateExecutiveSuccess extends ExecutivesState {}

class CreateExecutiveError extends ExecutivesState {
  final String message;

  CreateExecutiveError(this.message);
}

/// ===== EDIT =====
class EditExecutiveLoading extends ExecutivesState {}

class EditExecutiveSuccess extends ExecutivesState {}

class EditExecutiveError extends ExecutivesState {
  final String message;

  EditExecutiveError(this.message);
}

/// ===== DELETE =====
class DeleteExecutiveLoading extends ExecutivesState {}

class DeleteExecutiveSuccess extends ExecutivesState {}

class DeleteExecutiveError extends ExecutivesState {
  final String message;

  DeleteExecutiveError(this.message);
}

/// ===== GET BY PROFILE ID =====
class GetExecutiveByIdLoading extends ExecutivesState {}

class GetExecutiveByIdSuccess extends ExecutivesState {
  final GetExecutiveByProfileIdResponseModel data;

  GetExecutiveByIdSuccess(this.data);
}

class GetExecutiveByIdError extends ExecutivesState {
  final String message;

  GetExecutiveByIdError(this.message);
}

// ─── Send Signature ───────────────────────────────────
class SendSignatureLoading extends ExecutivesState {}

class SendSignatureSuccess extends ExecutivesState {}

class SendSignatureFailure extends ExecutivesState {
  final String error;

  SendSignatureFailure(this.error);
}