part of 'policy_cubit.dart';


@immutable
sealed class PolicyState {}

final class PolicyInitial extends PolicyState {}

final class PolicyRequestsLoading extends PolicyState {}

final class PolicyPoliciesLoading extends PolicyState {}

final class PolicyBothSuccess extends PolicyState {
  final PoliciesResponseModel? policies;
  final PoliciesRequestResponseModel? requests;

  PolicyBothSuccess({
    this.policies,
    this.requests,
  });

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