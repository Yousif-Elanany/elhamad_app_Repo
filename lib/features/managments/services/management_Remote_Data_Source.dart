import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../../Committees/Model/UsersSigntureRequestModel.dart';
import '../Models/CreateBoardMemberRequestlModel.dart';
import '../Models/CreateBoardRequestModel.dart';
import '../Models/DiewctorModel.dart';
import '../Models/ShareHolderResponse.dart';
import '../Models/editMemberOfBoardRequestModel.dart';
import '../Models/endMemberMemberShipModel.dart';
import '../Models/memberOfBoardResponseModel.dart';

class ManagementRemoteDataSource {
  ///// جلب معلومات الشركة
  Future<DirectorsResponseModel> getDirectors(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return DirectorsResponseModel.fromJson(response.data);
  }

  Future<MemberResponseModel> getMembers(
    String companyId,
    String boardId,
  ) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors/$boardId/members",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");

    return MemberResponseModel.fromJson(response.data);
  }

  Future<ShareHoldersResponseModel> getShareHolders(String companyId) async {
    final response = await DioHelper.get(
      "companies/$companyId/shareholders",
      query: {"Accept-Language": "ar"},
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");
    return ShareHoldersResponseModel.fromJson(response.data);
  }

  Future<void> createNewBoardDirectorRequest(
    String companyId,
    CreateBoardRequestModel requestModel,
  ) async {
    print(
      "Creating NewBoardDirector request with data: ${requestModel.toJson()}",
    );
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
      data: requestModel.toJson(),
    );
    print("response===> ${response.data}");
  }

  Future<void> createMemberRequest(
    String companyId,
    int boardId,
    CreateBoardMemberRequestlModel requestModel,
  ) async {
    print("Creating member request with data: ${requestModel.toJson()}");
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors/$boardId/members",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
      data: requestModel.toJson(),
    );
    print("response===> ${response.data}");
  }

  Future<MemberOfBoardResponseModel> getMemberOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
  ) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors/$boardId/members/$profileId",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");

    return MemberOfBoardResponseModel.fromJson(response.data);
  }

  Future<void> editMemberOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
    EditMemberOfBoardModel requestModel,
  ) async {
    final response = await DioHelper.put(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors/$boardId/members/$profileId",
      data: requestModel.toJson(),
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");
  }

  Future<void> deleteMemberOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
  ) async {
    final response = await DioHelper.delete(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors/$boardId/members/$profileId",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");
  }

  Future<void> endMemberMemberShipOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
    EndMemberMemberShipModel requestModel,
  ) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors/$boardId/members/$profileId/end-membership",
      data: requestModel.toJson(),
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");
  }

  sendSignatureRequest(
      String companyId,
      UsersSigntureRequestModel model,
      ) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/signature-requests",
      data: model.toJson(),
      requiresToken: true,
    );
    print("response===> ${response.data}");
  }
}
