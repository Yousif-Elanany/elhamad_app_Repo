import 'package:alhamd/features/Organizations/Services/organization_Remote_Data_Source.dart';
import 'package:alhamd/features/Organizations/model/EditMeetingRequestModel.dart';
import 'package:alhamd/features/Organizations/model/MeetingDetailModel.dart';
import 'package:alhamd/features/Organizations/model/MeetingRequestModel.dart';
import 'package:alhamd/features/home/models/SubscriptionsModel.dart';
import 'package:alhamd/features/managments/Models/DiewctorModel.dart';
import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';

import '../model/OrganizationsRequestsResponseModel.dart';
import '../model/OrganizationsResponseModel.dart';

class OrganizationRepository implements OrganizationRemoteDataSource {
  final OrganizationRemoteDataSource remote;

  OrganizationRepository(this.remote);

  @override
  Future<OrganizationsRequestsResponseModel> getCompanyMeetingsRequests(
    String companyId,
  ) {
    return remote.getCompanyMeetingsRequests(companyId);
  }

  @override
  Future<OrganizationsResponseModel> getCompanyMeetings(String companyId) {
    return remote.getCompanyMeetings(companyId);
  }

  @override
  Future<MeetingDetailModel> getCompanyMeetingRequestDetail(
    String companyId,
    int meetingId,
  ) {
    return remote.getCompanyMeetingRequestDetail(companyId, meetingId);
  }

  @override
  Future<void> cancelMeetingRequest(String companyId, int meetingRequestId) {
    return remote.cancelMeetingRequest(companyId, meetingRequestId);
  }

  @override
  Future<void> createMeetingRequest(
    String companyId,
    MeetingRequestModel requestModel,
  ) {
    return remote.createMeetingRequest(companyId, requestModel);
  }

  @override
  Future<void> editMeetingTime(
    String companyId,
    int meetingRequestId,
    EditMeetingRequestModel Model,
  ) {
    return remote.editMeetingTime(companyId, meetingRequestId, Model);
  }

  @override
  Future<MeetingDetailModel> getCompanyMeetingsDetailById(String companyId, int meetingId) {
    return remote.getCompanyMeetingsDetailById(companyId, meetingId);
  }
}
