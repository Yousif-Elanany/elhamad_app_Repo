part of 'organization_cubit.dart';

@immutable
abstract class OrganizationState {}

// initial
class OrganizationInitial extends OrganizationState {}

/// ================== Meetings ==================
class GetMeetingsLoading extends OrganizationState {}

class GetMeetingsSuccess extends OrganizationState {
  final OrganizationsResponseModel data;

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

/// ================== Meeting Detail ==================
class GetMeetingDetailLoading extends OrganizationState {}

class GetMeetingDetailSuccess extends OrganizationState {
  final MeetingDetailModel data;

  GetMeetingDetailSuccess(this.data);
}

class GetMeetingDetailError extends OrganizationState {
  final String error;

  GetMeetingDetailError(this.error);
}

// ===== Cancel Meeting =====
class CancelMeetingInitial extends OrganizationState {}

class CancelMeetingLoading extends OrganizationState {}

class CancelMeetingSuccess extends OrganizationState {}

class CancelMeetingError extends OrganizationState {
  final String message;

  CancelMeetingError(this.message);
}

// ===== Create Meeting =====
class CreateMeetingLoading extends OrganizationState {}

class CreateMeetingSuccess extends OrganizationState {}

class CreateMeetingError extends OrganizationState {
  final String message;

  CreateMeetingError(this.message);
}

// ===== Edit Meeting =====
class EditMeetingLoading extends OrganizationState {}

class EditMeetingSuccess extends OrganizationState {}

class EditMeetingError extends OrganizationState {
  final String message;

  EditMeetingError(this.message);
}
