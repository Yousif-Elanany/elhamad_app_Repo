import 'package:alhamd/features/Committees/Model/CreateCommitMemberRequest.dart';
import 'package:alhamd/features/Committees/Model/CreateCommitRequest.dart';
import 'package:alhamd/features/Committees/Model/UsersSigntureRequestModel.dart';
import 'package:alhamd/features/Committees/Model/editMemberModel.dart';
import 'package:alhamd/features/Committees/Model/getCommitMembersResponse.dart';
import 'package:alhamd/features/home/models/SubscriptionsModel.dart';
import 'package:alhamd/features/managments/Models/DiewctorModel.dart';
import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';

import '../Model/committeesResponseModel.dart';
import '../Services/Committees_Remote_Data_Source.dart';
class CommitteesRepository implements CommitteesRemoteDataSource {
  final CommitteesRemoteDataSource remote;

  CommitteesRepository(this.remote);

  @override
  Future<CommitteesResponseModel> getCommittees(String companyId) {
    return remote.getCommittees(companyId);
  }

  @override
  Future<CommitteesResponseModel> createCommittees(
      String companyId,
      CreateCommitRequest requestModel,
      ) {
    return remote.createCommittees(companyId, requestModel);
  }

  @override
  Future<CommitteesResponseModel> editCommitteesById(
      String companyId,
      CreateCommitRequest requestModel,
      int id,
      ) {
    return remote.editCommitteesById(companyId, requestModel, id);
  }

  @override
  Future<CommitteesResponseModel> deleteCommitteesById(
      String companyId,
      int id,
      ) {
    return remote.deleteCommitteesById(companyId, id);
  }

  @override
  Future<List<GetCommitMembersResponse>> getCommitteeMembersByCommitteeId(
      String companyId,
      int committeeId,
      ) {
    return remote.getCommitteeMembersByCommitteeId(companyId, committeeId);
  }

  @override
  Future<CommitteesResponseModel> createCommitteesMembersByCommitteeId(
      String companyId,
      int committeeId,
      CreateCommitMemberRequest request,
      ) {
    return remote.createCommitteesMembersByCommitteeId(companyId, committeeId, request);
  }

  @override
  Future<CommitteesResponseModel> editMembersByMembersId(
      String companyId,
      int id,
      EditMemberModel request,
      ) {
    return remote.editMembersByMembersId(companyId, id, request);
  }

  @override
  Future<CommitteesResponseModel> deleteMembersByMembersId(
      String companyId,
      int id,
      ) {
    return remote.deleteMembersByMembersId(companyId, id);
  }

  @override
  Future<CommitteesResponseModel> sendSignatureRequest(
      String companyId,
      int committeeId,
      UsersSigntureRequestModel model,
      ) {
    return remote.sendSignatureRequest(companyId, committeeId, model);
  }

  // ده موجود في الريبو القديم بس مش في الـ RemoteDataSource، شيله لو مش محتاجه
  @override
  Future<List<GetCommitMembersResponse>> getCommitteeMembersById(
      String companyId,
      int committeeId,
      ) {
    return remote.getCommitteeMembersByCommitteeId(companyId, committeeId);
  }
}