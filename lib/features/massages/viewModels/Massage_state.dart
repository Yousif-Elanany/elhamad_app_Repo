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

/// ================= CREATE =================
final class CreateMassageLoading extends MassageState {}

final class CreateMassageSuccess extends MassageState {}

final class CreateMassageError extends MassageState {
  final String message;

  CreateMassageError(this.message);
}

/// ================= GET BY ID =================
final class GetMassageByIdLoading extends MassageState {}

final class GetMassageByIdSuccess extends MassageState {
  final MassageDetailModel massage;

  GetMassageByIdSuccess(this.massage);
}

final class GetMassageByIdError extends MassageState {
  final String message;

  GetMassageByIdError(this.message);
}

/// ================= RESEND =================
final class ResendMassageLoading extends MassageState {}

final class ResendMassageSuccess extends MassageState {}

final class ResendMassageError extends MassageState {
  final String message;

  ResendMassageError(this.message);
}
