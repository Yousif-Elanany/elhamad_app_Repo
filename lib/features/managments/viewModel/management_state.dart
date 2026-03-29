part of 'management_cubit.dart';

@immutable
sealed class ManagementState {}

final class ManagementInitial extends ManagementState {}

// ─── Directors ───────────────────────────────────────
final class DirectorsLoading extends ManagementState {}

final class DirectorsSuccess extends ManagementState {
  final DirectorsResponseModel data;
  DirectorsSuccess(this.data);
}

final class DirectorsFailure extends ManagementState {
  final String error;
  DirectorsFailure(this.error);
}

// ─── Members ─────────────────────────────────────────
final class MembersLoading extends ManagementState {}

final class MembersSuccess extends ManagementState {
  final MemberResponseModel data;
  MembersSuccess(this.data);
}

final class MembersFailure extends ManagementState {
  final String error;
  MembersFailure(this.error);
}

// ─── ShareHolders ─────────────────────────────────────
final class ShareHoldersLoading extends ManagementState {}

final class ShareHoldersSuccess extends ManagementState {
  final ShareHoldersResponseModel data;
  ShareHoldersSuccess(this.data);
}

final class ShareHoldersFailure extends ManagementState {
  final String error;
  ShareHoldersFailure(this.error);
}

// ─── Create Board Director ────────────────────────────
class CreateBoardDirectorLoading extends ManagementState {}
class CreateBoardDirectorSuccess extends ManagementState {}
class CreateBoardDirectorFailure extends ManagementState {
  final String error;
  CreateBoardDirectorFailure(this.error);
}

// ─── Create Member ────────────────────────────────────
class CreateMemberLoading extends ManagementState {}
class CreateMemberSuccess extends ManagementState {}
class CreateMemberFailure extends ManagementState {
  final String error;
  CreateMemberFailure(this.error);
}

// ─── Get Member Profile ───────────────────────────────
class GetMemberProfileLoading extends ManagementState {}
class GetMemberProfileSuccess extends ManagementState {
  final MemberOfBoardResponseModel data;
  GetMemberProfileSuccess(this.data);
}
class GetMemberProfileFailure extends ManagementState {
  final String error;
  GetMemberProfileFailure(this.error);
}

// ─── Edit Member Profile ──────────────────────────────
class EditMemberProfileLoading extends ManagementState {}
class EditMemberProfileSuccess extends ManagementState {}
class EditMemberProfileFailure extends ManagementState {
  final String error;
  EditMemberProfileFailure(this.error);
}

// ─── Delete Member Profile ────────────────────────────
class DeleteMemberProfileLoading extends ManagementState {}
class DeleteMemberProfileSuccess extends ManagementState {}
class DeleteMemberProfileFailure extends ManagementState {
  final String error;
  DeleteMemberProfileFailure(this.error);
}

// ─── End Member Membership ────────────────────────────
class EndMemberShipLoading extends ManagementState {}
class EndMemberShipSuccess extends ManagementState {}
class EndMemberShipFailure extends ManagementState {
  final String error;
  EndMemberShipFailure(this.error);
}

// ─── Send Signature ───────────────────────────────────
class SendSignatureLoading extends ManagementState {}
class SendSignatureSuccess extends ManagementState {}
class SendSignatureFailure extends ManagementState {
  final String error;

  SendSignatureFailure(this.error);
}