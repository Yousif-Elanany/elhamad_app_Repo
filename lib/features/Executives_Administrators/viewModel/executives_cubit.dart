import 'package:bloc/bloc.dart';
import 'package:alhamd/features/Executives_Administrators/Models/createExecutiveRequestModel.dart';

import '../../Committees/Model/UsersSigntureRequestModel.dart';
import '../Models/EditExecutiveModel.dart';
import '../repos/Executives_Repo.dart';
import 'executives_state.dart';

class ExecutivesCubit extends Cubit<ExecutivesState> {
  final ExecutivesRepository repository;

  ExecutivesCubit(this.repository) : super(ExecutivesInitial());

  /// ===== GET ALL =====
  Future<void> getExecutives(String companyId) async {
    emit(ExecutivesLoading());

    try {
      final response = await repository.getExecutives(companyId);
      emit(ExecutivesSuccess(response));
    } catch (e) {
      emit(ExecutivesError(e.toString()));
    }
  }

  /// ===== CREATE =====
  Future<void> createExecutives(
    String companyId,
    CreateExecutiveRequestModel model,
  ) async {
    emit(CreateExecutiveLoading());

    try {
      await repository.createExecutives(companyId, model);
      emit(CreateExecutiveSuccess());
    } catch (e) {
      emit(CreateExecutiveError(e.toString()));
    }
  }

  /// ===== EDIT =====
  Future<void> editExecutive(
    String companyId,
    int profileId,
    EditExecutiveModel model,
  ) async {
    emit(EditExecutiveLoading());

    try {
      await repository.editExecutiveByProfileId(companyId, profileId, model);
      emit(EditExecutiveSuccess());
    } catch (e) {
      emit(EditExecutiveError(e.toString()));
    }
  }

  /// ===== DELETE =====
  Future<void> deleteExecutive(String companyId, int profileId) async {
    emit(DeleteExecutiveLoading());

    try {
      await repository.deleteExecutiveByProfileId(companyId, profileId);
      emit(DeleteExecutiveSuccess());
    } catch (e) {
      emit(DeleteExecutiveError(e.toString()));
    }
  }

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

  /// ===== GET BY ID =====
  Future<void> getExecutiveById(String companyId, int profileId) async {
    emit(GetExecutiveByIdLoading());

    try {
      final response = await repository.getExecutiveByProfileId(
        companyId,
        profileId,
      );
      emit(GetExecutiveByIdSuccess(response));
    } catch (e) {
      emit(GetExecutiveByIdError(e.toString()));
    }
  }
}
