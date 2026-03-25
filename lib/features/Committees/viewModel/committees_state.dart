part of 'committees_cubit.dart';

@immutable
sealed class CommitteesState {}

final class CommitteesInitial extends CommitteesState {}

// ===== Get Committees =====
final class GetCommitteesLoading extends CommitteesState {}

final class GetCommitteesSuccess extends CommitteesState {
  final CommitteesResponseModel data;
  GetCommitteesSuccess(this.data);
}

final class GetCommitteesError extends CommitteesState {
  final String error;
  GetCommitteesError(this.error);
}

// ===== Create Committees =====
final class CreateCommitteesLoading extends CommitteesState {}

final class CreateCommitteesSuccess extends CommitteesState {
  final Map<String,dynamic> data;
  CreateCommitteesSuccess(this.data);
}

final class CreateCommitteesError extends CommitteesState {
  final String error;
  CreateCommitteesError(this.error);
}

// ===== Edit Committees =====
final class EditCommitteesLoading extends CommitteesState {}

final class EditCommitteesSuccess extends CommitteesState {
  EditCommitteesSuccess();
}

final class EditCommitteesError extends CommitteesState {
  final String error;
  EditCommitteesError(this.error);
}

// ===== Delete Committees =====
final class DeleteCommitteesLoading extends CommitteesState {}

final class DeleteCommitteesSuccess extends CommitteesState {
  DeleteCommitteesSuccess();
}

final class DeleteCommitteesError extends CommitteesState {
  final String error;
  DeleteCommitteesError(this.error);
}

// ===== Get Committee Members =====
final class GetCommitteeMembersLoading extends CommitteesState {}

final class GetCommitteeMembersSuccess extends CommitteesState {
  final List<GetCommitMembersResponse> members;
  GetCommitteeMembersSuccess(this.members);
}

final class GetCommitteeMembersError extends CommitteesState {
  final String error;
  GetCommitteeMembersError(this.error);
}

// ===== Create Committee Member =====
final class CreateCommitteeMemberLoading extends CommitteesState {}

final class CreateCommitteeMemberSuccess extends CommitteesState {
  CreateCommitteeMemberSuccess();
}

final class CreateCommitteeMemberError extends CommitteesState {
  final String error;
  CreateCommitteeMemberError(this.error);
}

// ===== Edit Member =====
final class EditMemberLoading extends CommitteesState {}

final class EditMemberSuccess extends CommitteesState {
  final CommitteesResponseModel data;
  EditMemberSuccess(this.data);
}

final class EditMemberError extends CommitteesState {
  final String error;
  EditMemberError(this.error);
}

// ===== Delete Member =====
final class DeleteMemberLoading extends CommitteesState {}

final class DeleteMemberSuccess extends CommitteesState {
  final CommitteesResponseModel data;
  DeleteMemberSuccess(this.data);
}

final class DeleteMemberError extends CommitteesState {
  final String error;
  DeleteMemberError(this.error);
}

// ===== Send Signature Request =====
final class SendSignatureRequestLoading extends CommitteesState {}

final class SendSignatureRequestSuccess extends CommitteesState {
  final CommitteesResponseModel data;
  SendSignatureRequestSuccess(this.data);
}

final class SendSignatureRequestError extends CommitteesState {
  final String error;
  SendSignatureRequestError(this.error);
}