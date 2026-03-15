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
  final Map<String, dynamic> data;
  ShareHoldersSuccess(this.data);
}

final class ShareHoldersFailure extends ManagementState {
  final String error;
  ShareHoldersFailure(this.error);
}
