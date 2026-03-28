import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../model/EditMeetingRequestModel.dart';
import '../model/MeetingDetailModel.dart';
import '../model/MeetingRequestModel.dart';
import '../model/OrganizationsRequestsResponseModel.dart';
import '../model/OrganizationsResponseModel.dart';

class OrganizationRemoteDataSource {
  ///// جلب معلومات الشركة
  Future<OrganizationsResponseModel> getCompanyMeetings(
    String companyId,
  ) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/meetings",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return OrganizationsResponseModel.fromJson(response.data);
  }

  Future<OrganizationsRequestsResponseModel> getCompanyMeetingsRequests(
    String companyId,
  ) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/meeting-requests",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");

    return OrganizationsRequestsResponseModel.fromJson(response.data);
  }

  Future<MeetingDetailModel> getCompanyMeetingDetail(
      String companyId,
      int meetingId,
      ) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/meetings/$meetingId",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return MeetingDetailModel.fromJson(response.data);
  }

  // Create Meeting Request
  Future<void> createMeetingRequest(
    String companyId,
    MeetingRequestModel requestModel,
  ) async {
    print("Creating meeting request with data: ${requestModel.toJson()}");
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/meeting-requests",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
      data: requestModel.toJson(),
    );
    print("response===> ${response.data}");
  }

  Future<void> editMeetingTime(
    String companyId,
    int meetingRequestId,
    EditMeetingRequestModel Model,
  ) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/meeting-requests",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
      data: Model.toJson(),
    );
    print("response===> ${response.data}");
  }

  Future<void> cancelMeetingRequest(
    String companyId,
    int meetingRequestId,
  ) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/meeting-requests",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
          );
    print("response===> ${response.data}");
  }
}
