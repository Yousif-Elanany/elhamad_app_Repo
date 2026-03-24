import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Model/CreateCommitMemberRequest.dart';
import '../Model/CreateCommitRequest.dart';
import '../Model/UsersSigntureRequestModel.dart';
import '../Model/committeesResponseModel.dart';
import '../Model/editMemberModel.dart';
import '../Model/getCommitMembersResponse.dart';

class CommitteesRemoteDataSource {

     ///// جلب معلومات الشركة
  Future<CommitteesResponseModel> getCommittees(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/committees",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return CommitteesResponseModel.fromJson(response.data);
  }
  Future<CommitteesResponseModel> createCommittees(String companyId,CreateCommitRequest requestModel) async {
    final response = await DioHelper.post(
      data: requestModel.toJson(),
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/committees",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return CommitteesResponseModel.fromJson(response.data);
  }
  Future<CommitteesResponseModel> editCommitteesById(String companyId,CreateCommitRequest requestModel,int id) async {
    final response = await DioHelper.put(
      data: requestModel.toJson(),
      query: {"Accept-Language": "ar","pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/committees/$id",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return CommitteesResponseModel.fromJson(response.data);
  }
  Future<CommitteesResponseModel> deleteCommitteesById(String companyId,int id) async {
    final response = await DioHelper.delete(
      query: {"Accept-Language": "ar","pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/committees/$id",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return CommitteesResponseModel.fromJson(response.data);
  }
  Future<List<GetCommitMembersResponse>> getCommitteeMembersByCommitteeId(
      String companyId,
      int committeeId,
      ) async {
    final response = await DioHelper.get(
      "companies/$companyId/committees/$committeeId/members",
      query: {
        "Accept-Language": "ar",
        "pageNumber": "1",
        "pageSize": "10",
      },
      requiresToken: true,
    );

    print("response===> ${response.data}");

    return List<GetCommitMembersResponse>.from(
      (response.data as List).map((x) => GetCommitMembersResponse.fromJson(x)),
    );
  }

  Future<CommitteesResponseModel> createCommitteesMembersByCommitteeId(String companyId,int committeeId ,CreateCommitMemberRequest request) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/committees/$committeeId/members",
      data: request.toJson(),
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return CommitteesResponseModel.fromJson(response.data);
  }
  Future<CommitteesResponseModel> editMembersByMembersId(String companyId,int id,EditMemberModel request) async {
    final response = await DioHelper.put(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/committees/members/$id",
      data:request.toJson(),
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return CommitteesResponseModel.fromJson(response.data);
  }

  Future<CommitteesResponseModel> deleteMembersByMembersId(String companyId,int id) async {
    final response = await DioHelper.delete(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/committees/members/$id",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return CommitteesResponseModel.fromJson(response.data);
  }

  Future<CommitteesResponseModel> sendSignatureRequest(String companyId,int committeeId ,UsersSigntureRequestModel model) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/signature-requests",
      data: model.toJson(),
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return CommitteesResponseModel.fromJson(response.data);
  }

}
