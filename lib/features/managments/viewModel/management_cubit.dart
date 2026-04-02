import 'package:alhamd/features/managments/repos/Managment_Repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Committees/Model/UsersSigntureRequestModel.dart';
import '../Models/CreateBoardMemberRequestlModel.dart';
import '../Models/CreateBoardRequestModel.dart';
import '../Models/CreateShareHolderRequest.dart';
import '../Models/DiewctorModel.dart';
import '../Models/GetShareHolderDetailModel.dart';
import '../Models/MemberModel.dart';
import '../Models/ShareHolderResponse.dart';
import '../Models/editMemberOfBoardRequestModel.dart';
import '../Models/editShareModel.dart';
import '../Models/endMemberMemberShipModel.dart';
import '../Models/memberOfBoardResponseModel.dart';

part 'management_state.dart';

class ManagementCubit extends Cubit<ManagementState> {
  final ManagementRepository repository;

  ManagementCubit(this.repository) : super(ManagementInitial());

  // ─── Directors ───────────────────────────────────────
  Future<void> getDirectors(String companyId) async {
    try {
      emit(DirectorsLoading());
      final data = await repository.getDirectors(companyId);
      emit(DirectorsSuccess(data));
    } catch (e) {
      emit(DirectorsFailure(e.toString()));
    }
  }

  // ─── Members ─────────────────────────────────────────
  Future<void> getMembers(String companyId, String boardId) async {
    try {
      emit(MembersLoading());
      final data = await repository.getMembers(companyId, boardId);
      emit(MembersSuccess(data));
    } catch (e) {
      emit(MembersFailure(e.toString()));
    }
  }

  // ─── ShareHolders ─────────────────────────────────────
  Future<void> getShareHolders(String companyId) async {
    try {
      emit(ShareHoldersLoading());
      final data = await repository.getShareHolders(companyId);
      emit(ShareHoldersSuccess(data));
    } catch (e) {
      emit(ShareHoldersFailure(e.toString()));
    }
  }

  // ─── Create Board Director Request ───────────────────
  Future<void> createNewBoardDirectorRequest(
    String companyId,
    CreateBoardRequestModel requestModel,
  ) async {
    try {
      emit(CreateBoardDirectorLoading());
      await repository.createNewBoardDirectorRequest(companyId, requestModel);
      emit(CreateBoardDirectorSuccess());
    } catch (e) {
      emit(CreateBoardDirectorFailure(e.toString()));
    }
  }

  // ─── Create Member Request ────────────────────────────
  Future<void> createMemberRequest(
    String companyId,
    int boardId,
    CreateBoardMemberRequestlModel requestModel,
  ) async {
    try {
      emit(CreateMemberLoading());
      await repository.createMemberRequest(companyId, boardId, requestModel);
      emit(CreateMemberSuccess());
    } catch (e) {
      emit(CreateMemberFailure(e.toString()));
    }
  }

  // ─── Get Member Profile ───────────────────────────────
  Future<void> getMemberOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
  ) async {
    try {
      emit(GetMemberProfileLoading());
      final data = await repository.getMemberOfBoardProfileId(
        companyId,
        boardId,
        profileId,
      );
      emit(GetMemberProfileSuccess(data));
    } catch (e) {
      emit(GetMemberProfileFailure(e.toString()));
    }
  }

  // ─── Edit Member Profile ──────────────────────────────
  Future<void> editMemberOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
    EditMemberOfBoardModel requestModel,
  ) async {
    try {
      emit(EditMemberProfileLoading());
      await repository.editMemberOfBoardProfileId(
        companyId,
        boardId,
        profileId,
        requestModel,
      );
      emit(EditMemberProfileSuccess());
    } catch (e) {
      emit(EditMemberProfileFailure(e.toString()));
    }
  }

  // ─── Delete Member Profile ────────────────────────────
  Future<void> deleteMemberOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
  ) async {
    try {
      emit(DeleteMemberProfileLoading());
      await repository.deleteMemberOfBoardProfileId(
        companyId,
        boardId,
        profileId,
      );
      emit(DeleteMemberProfileSuccess());
    } catch (e) {
      emit(DeleteMemberProfileFailure(e.toString()));
    }
  }

  // ─── End Member Membership ────────────────────────────
  Future<void> endMemberMemberShipOfBoardProfileId(
    String companyId,
    int boardId,
    int profileId,
    EndMemberMemberShipModel requestModel,
  ) async {
    try {
      emit(EndMemberShipLoading());
      await repository.endMemberMemberShipOfBoardProfileId(
        companyId,
        boardId,
        profileId,
        requestModel,
      );
      emit(EndMemberShipSuccess());
    } catch (e) {
      emit(EndMemberShipFailure(e.toString()));
    }
  }

  // ─── Send Signature Request ───────────────────────────
  Future<void> sendSignatureRequest(
    String companyId,
    UsersSigntureRequestModel model,
  ) async {
    try {
      emit(SendSignatureLoading());
      await repository.sendSignatureRequest(companyId, model);
      emit(SendSignatureSuccess());
    } catch (e) {
      emit(SendSignatureFailure(e.toString()));
    }
  }

  /// ================= CREATE =================
  Future<void> createShareHolder(
    String companyId,
    CreateShareHolderRequestModel model,
  ) async {
    emit(CreateShareHolderLoading());

    try {
      await repository.createShareHolder(companyId, model);
      emit(CreateShareHolderSuccess());
    } catch (e) {
      emit(CreateShareHolderError(e.toString()));
    }
  }

  /// ================= EDIT =================
  Future<void> editShareHolder(
    String companyId,
    int profileId,
    EditShareHolderRequestModel model,
  ) async {
    emit(EditShareHolderLoading());

    try {
      await repository.editShareHolderByProfileId(companyId, profileId, model);
      emit(EditShareHolderSuccess());
    } catch (e) {
      emit(EditShareHolderError(e.toString()));
    }
  }

  /// ================= GET BY ID =================
  Future<void> getShareHolderById(String companyId, int profileId) async {
    emit(GetShareHolderLoading());

    try {
      final data = await repository.getShareHolderById(companyId, profileId);

      emit(GetShareHolderSuccess(data));
    } catch (e) {
      emit(GetShareHolderError(e.toString()));
    }
  }
}
