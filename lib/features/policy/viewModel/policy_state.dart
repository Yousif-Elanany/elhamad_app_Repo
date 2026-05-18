part of 'policy_cubit.dart';

@immutable
sealed class PolicyState {}

final class PolicyInitial extends PolicyState {}

final class PolicyRequestsLoading extends PolicyState {}

final class PolicyPoliciesLoading extends PolicyState {}

final class PolicyBothSuccess extends PolicyState {
  final PoliciesResponseModel? policies;
  final PoliciesRequestResponseModel? requests;

  PolicyBothSuccess({this.policies, this.requests});

  PolicyBothSuccess copyWith({
    PoliciesResponseModel? policies,
    PoliciesRequestResponseModel? requests,
  }) {
    return PolicyBothSuccess(
      policies: policies ?? this.policies,
      requests: requests ?? this.requests,
    );
  }
}

final class PolicyError extends PolicyState {
  final String message;

  PolicyError(this.message);
}

/// ================= CREATE =================
final class CreatePolicyRequestLoading extends PolicyState {}

final class CreatePolicyRequestSuccess extends PolicyState {}

final class CreatePolicyRequestError extends PolicyState {
  final String message;

  CreatePolicyRequestError(this.message);
}

/// ================= DELETE =================
final class DeletePolicyRequestLoading extends PolicyState {}

final class DeletePolicyRequestSuccess extends PolicyState {}

final class DeletePolicyRequestError extends PolicyState {
  final String message;

  DeletePolicyRequestError(this.message);
}

/// ================= EDIT =================
final class EditPolicyRequestLoading extends PolicyState {}

final class EditPolicyRequestSuccess extends PolicyState {}

final class EditPolicyRequestError extends PolicyState {
  final String message;

  EditPolicyRequestError(this.message);
}

/// ================= GET BY ID =================
final class GetPolicyRequestByIdLoading extends PolicyState {}

final class GetPolicyRequestByIdSuccess extends PolicyState {
  final GetPolicyRequestDetailModel data;

  GetPolicyRequestByIdSuccess(this.data);
}

final class GetPolicyRequestByIdError extends PolicyState {
  final String message;

  GetPolicyRequestByIdError(this.message);
}
