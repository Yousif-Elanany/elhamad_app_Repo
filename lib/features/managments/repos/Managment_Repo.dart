import 'package:alhamd/features/Committees/Model/UsersSigntureRequestModel.dart';
import 'package:alhamd/features/home/models/SubscriptionsModel.dart';
import 'package:alhamd/features/managments/Models/CreateBoardMemberRequestlModel.dart';
import 'package:alhamd/features/managments/Models/DiewctorModel.dart';
import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:alhamd/features/managments/Models/editMemberOfBoardRequestModel.dart';
import 'package:alhamd/features/managments/Models/endMemberMemberShipModel.dart';
import 'package:alhamd/features/managments/Models/memberOfBoardResponseModel.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';

import '../Models/CreateBoardRequestModel.dart';
import '../Models/ShareHolderResponse.dart';

class ManagementRepository implements ManagementRemoteDataSource {
  final ManagementRemoteDataSource remote;

  ManagementRepository(this.remote);

  @override
  Future<DirectorsResponseModel> getDirectors(String companyId) {
    return remote.getDirectors(companyId);
  }

  @override
  Future<MemberResponseModel> getMembers(String companyId, String boardId) {
    return remote.getMembers(companyId, boardId);
  }

  @override
  Future<ShareHoldersResponseModel> getShareHolders(String companyId) {
    return remote.getShareHolders(companyId);
  }

  @override
  Future<void> createNewBoardDirectorRequest(
    String companyId,
    CreateBoardRequestModel requestModel,
  ) {
    return remote.createNewBoardDirectorRequest(companyId, requestModel);
  }

  @override
  Future<void> createMemberRequest(
    String companyId,
    int boardId,
    CreateBoardMemberRequestlModel requestModel,
  ) {
    return remote.createMemberRequest(companyId, boardId, requestModel);
  }

  @override
  Future<MemberOfBoardResponseModel> getMemberOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
  ) {
    return remote.getMemberOfBoardProfileId(companyId, boardId, profileId);
  }

  @override
  Future<void> editMemberOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
    EditMemberOfBoardModel requestModel,
  ) {
    return remote.editMemberOfBoardProfileId(
      companyId,
      boardId,
      profileId,
      requestModel,
    );
  }

  @override
  Future<void> deleteMemberOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
  ) {
    return remote.deleteMemberOfBoardProfileId(companyId, boardId, profileId);
  }

  @override
  Future<void> endMemberMemberShipOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
    EndMemberMemberShipModel requestModel,
  ) {
    return remote.endMemberMemberShipOfBoardProfileId(
      companyId,
      boardId,
      profileId,
      requestModel,
    );
  }

  @override
  sendSignatureRequest(String companyId, UsersSigntureRequestModel model) {
    return remote.sendSignatureRequest(companyId, model);
  }
}
