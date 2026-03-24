import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Model/CreateCommitMemberRequest.dart';
import '../Model/CreateCommitRequest.dart';
import '../Model/UsersSigntureRequestModel.dart';
import '../Model/committeesResponseModel.dart';
import '../Model/editMemberModel.dart';
import '../Model/getCommitMembersResponse.dart';
import '../Repos/Commites_Repo.dart';

part 'committees_state.dart';

class CommitteesCubit extends Cubit<CommitteesState> {
  final CommitteesRepository repository;

  CommitteesCubit(this.repository) : super(CommitteesInitial());

  // ===== Get Committees =====
  Future<void> getCommittees(String companyId) async {
    emit(GetCommitteesLoading());
    try {
      final response = await repository.getCommittees(companyId);
      emit(GetCommitteesSuccess(response));
    } catch (e) {
      emit(GetCommitteesError(e.toString()));
    }
  }

  // ===== Create Committees =====
  Future<void> createCommittees(String companyId, CreateCommitRequest request) async {
    emit(CreateCommitteesLoading());
    try {
      final response = await repository.createCommittees(companyId, request);
      emit(CreateCommitteesSuccess(response));
    } catch (e) {
      emit(CreateCommitteesError(e.toString()));
    }
  }

  // ===== Edit Committees =====
  Future<void> editCommitteesById(String companyId, CreateCommitRequest request, int id) async {
    emit(EditCommitteesLoading());
    try {
      final response = await repository.editCommitteesById(companyId, request, id);
      emit(EditCommitteesSuccess(response));
    } catch (e) {
      emit(EditCommitteesError(e.toString()));
    }
  }

  // ===== Delete Committees =====
  Future<void> deleteCommitteesById(String companyId, int id) async {
    emit(DeleteCommitteesLoading());
    try {
      final response = await repository.deleteCommitteesById(companyId, id);
      emit(DeleteCommitteesSuccess(response));
    } catch (e) {
      emit(DeleteCommitteesError(e.toString()));
    }
  }

  // ===== Get Committee Members =====
  Future<void> getCommitteeMembers(String companyId, int committeeId) async {
    emit(GetCommitteeMembersLoading());
    try {
      final response = await repository.getCommitteeMembersByCommitteeId(companyId, committeeId);
      emit(GetCommitteeMembersSuccess(response));
    } catch (e) {
      emit(GetCommitteeMembersError(e.toString()));
    }
  }

  // ===== Create Committee Member =====
  Future<void> createCommitteeMember(String companyId, int committeeId, CreateCommitMemberRequest request) async {
    emit(CreateCommitteeMemberLoading());
    try {
      final response = await repository.createCommitteesMembersByCommitteeId(companyId, committeeId, request);
      emit(CreateCommitteeMemberSuccess(response));
    } catch (e) {
      emit(CreateCommitteeMemberError(e.toString()));
    }
  }

  // ===== Edit Member =====
  Future<void> editMember(String companyId, int id, EditMemberModel request) async {
    emit(EditMemberLoading());
    try {
      final response = await repository.editMembersByMembersId(companyId, id, request);
      emit(EditMemberSuccess(response));
    } catch (e) {
      emit(EditMemberError(e.toString()));
    }
  }

  // ===== Delete Member =====
  Future<void> deleteMember(String companyId, int id) async {
    emit(DeleteMemberLoading());
    try {
      final response = await repository.deleteMembersByMembersId(companyId, id);
      emit(DeleteMemberSuccess(response));
    } catch (e) {
      emit(DeleteMemberError(e.toString()));
    }
  }

  // ===== Send Signature Request =====
  Future<void> sendSignatureRequest(String companyId, int committeeId, UsersSigntureRequestModel model) async {
    emit(SendSignatureRequestLoading());
    try {
      final response = await repository.sendSignatureRequest(companyId, committeeId, model);
      emit(SendSignatureRequestSuccess(response));
    } catch (e) {
      emit(SendSignatureRequestError(e.toString()));
    }
  }
}