import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Models/MassageResponseModel.dart';
import '../Repos/Massage_Repo.dart';

part 'Massage_state.dart';

class MassageCubit extends Cubit<MassageState> {
  final MassageRepository repository;

  MassageCubit(this.repository) : super(MassageInitial());

  Future<void> getMessages(String companyId) async {
    emit(MassageLoading());

    try {
      final response = await repository.getMassage(  companyId);

      emit(MassageSuccess(response)); // لو بيرجع List
    } catch (e) {
      emit(MassageError(e.toString()));
    }
  }
}