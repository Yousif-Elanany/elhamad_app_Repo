part of 'organization_cubit.dart';

@immutable
abstract class OrganizationState {}

// initial
class OrganizationInitial extends OrganizationState {}

/// ================== Meetings ==================
class GetMeetingsLoading extends OrganizationState {}

class GetMeetingsSuccess extends OrganizationState {
  final   OrganizationsResponseModel data;

  GetMeetingsSuccess(this.data);
}

class GetMeetingsError extends OrganizationState {
  final String error;

  GetMeetingsError(this.error);
}

/// ================== Requests ==================
class GetRequestsLoading extends OrganizationState {}

class GetRequestsSuccess extends OrganizationState {
  final OrganizationsRequestsResponseModel data;

  GetRequestsSuccess(this.data);
}

class GetRequestsError extends OrganizationState {
  final String error;

  GetRequestsError(this.error);
}