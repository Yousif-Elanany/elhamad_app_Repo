import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Models/MassageDetailResponseModel.dart';
import '../Models/MassageResponseModel.dart';
import '../Models/createMassageRequestModel.dart';
import '../Repos/Massage_Repo.dart';

part 'Massage_state.dart';

class MassageCubit extends Cubit<MassageState> {
  final MassageRepository repository;

  MassageCubit(this.repository) : super(MassageInitial());

  Future<void> getMessages(String companyId) async {
    emit(MassageLoading());

    try {
      final response = await repository.getMassage(companyId);

      emit(MassageSuccess(response)); // لو بيرجع List
    } catch (e) {
      emit(MassageError(e.toString()));
    }
  }

  /// ================= CREATE =================
  Future<void> createMassage(String companyId, CreateMassageModel model) async {
    emit(CreateMassageLoading());

    try {
      await repository.createMassage(companyId, model);

      emit(CreateMassageSuccess());

      // refresh list بعد النجاح
      await getMessages(companyId);
    } catch (e) {
      emit(CreateMassageError(e.toString()));
    }
  }

  /// ================= GET BY ID =================
  Future<void> getMassageById(String companyId, int massageId) async {
    emit(GetMassageByIdLoading());

    try {
      final response = await repository.getMassageById(companyId, massageId);

      emit(GetMassageByIdSuccess(response));
    } catch (e) {
      emit(GetMassageByIdError(e.toString()));
    }
  }

  /// ================= RESEND =================
  Future<void> resendMassageById(String companyId, int massageId) async {
    emit(ResendMassageLoading());

    try {
      await repository.resendMassageById(companyId, massageId);

      emit(ResendMassageSuccess());

      // refresh بعد resend
      await getMessages(companyId);
    } catch (e) {
      emit(ResendMassageError(e.toString()));
    }
  }
}
