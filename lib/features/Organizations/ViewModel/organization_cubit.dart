import 'package:alhamd/features/Organizations/Repos/Organization_Repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
      final response =
      await repository.getCompanyMeetingsRequests(companyId);
      emit(GetRequestsSuccess(response));
    } catch (e) {
      emit(GetRequestsError(e.toString()));
    }
  }
}