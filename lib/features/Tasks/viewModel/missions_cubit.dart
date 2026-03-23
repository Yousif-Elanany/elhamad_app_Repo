import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Models/TaskResponseModel.dart';
import '../repos/TaskRepo.dart';

part 'missions_state.dart';

class MissionsCubit extends Cubit<MissionsState> {


  final MissionsRepository repository;

  MissionsCubit(this.repository) : super(MissionsInitial());


  Future<void> getMissions(String companyId) async {
    emit(MissionsLoading());

    try {
      final response = await repository.getMissions(companyId);

      emit(MissionsSuccess(response)); // لو بيرجع List
    } catch (e) {
      emit(MissionsError(e.toString()));
    }
  }
}
