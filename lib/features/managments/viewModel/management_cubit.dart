import 'package:alhamd/features/managments/repos/Managment_Repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Models/DiewctorModel.dart';
import '../Models/MemberModel.dart';

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
  Future<void> getShareHolders() async {
    try {
      emit(ShareHoldersLoading());
      final data = await repository.getShareHolders();
      emit(ShareHoldersSuccess(data));
    } catch (e) {
      emit(ShareHoldersFailure(e.toString()));
    }
  }
}
