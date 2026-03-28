import 'package:alhamd/features/Organizations/Repos/Organization_Repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/EditMeetingRequestModel.dart';
import '../model/MeetingDetailModel.dart';
import '../model/MeetingRequestModel.dart';
import '../model/OrganizationsRequestsResponseModel.dart';
import '../model/OrganizationsResponseModel.dart';

part 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  final OrganizationRepository repository;

  OrganizationCubit(this.repository) : super(OrganizationInitial());

  /// ================== Get Meetings ==================
  Future<void> getCompanyMeetings(String companyId) async {
    emit(GetMeetingsLoading());

    try {
      final response = await repository.getCompanyMeetings(companyId);
      emit(GetMeetingsSuccess(response));
    } catch (e) {
      emit(GetMeetingsError(e.toString()));
    }
  }

  /// ================== Get Requests ==================
  Future<void> getCompanyMeetingsRequests(String companyId) async {
    emit(GetRequestsLoading());

    try {
      final response = await repository.getCompanyMeetingsRequests(companyId);
      emit(GetRequestsSuccess(response));
    } catch (e) {
      emit(GetRequestsError(e.toString()));
    }
  }

  /// ================== Get Meeting Detail ==================

  Future<void> getCompanyMeetingDetail(String companyId, int meetingId) async {
    emit(GetMeetingDetailLoading());

    try {
      final response = await repository.getCompanyMeetingDetail(
        companyId,
        meetingId,
      );
      emit(GetMeetingDetailSuccess(response));
    } catch (e) {
      emit(GetMeetingDetailError(e.toString()));
    }
  }

  Future<void> cancelMeetingRequest(
    String companyId,
    int meetingRequestId,
  ) async {
    emit(CancelMeetingLoading());
    try {
      await repository.cancelMeetingRequest(companyId, meetingRequestId);
      emit(CancelMeetingSuccess());
    } catch (e) {
      emit(CancelMeetingError(e.toString()));
    }
  }

  // ================= Create =================
  Future<void> createMeetingRequest(
    String companyId,
    MeetingRequestModel requestModel,
  ) async {
    emit(CreateMeetingLoading());
    try {
      await repository.createMeetingRequest(companyId, requestModel);
      emit(CreateMeetingSuccess());
    } catch (e) {
      emit(CreateMeetingError(e.toString()));
    }
  }

  // ================= Edit =================
  Future<void> editMeetingTime(
    String companyId,
    int meetingRequestId,
    EditMeetingRequestModel model,
  ) async {
    emit(EditMeetingLoading());
    try {
      await repository.editMeetingTime(companyId, meetingRequestId, model);
      emit(EditMeetingSuccess());
    } catch (e) {
      emit(EditMeetingError(e.toString()));
    }
  }
}
