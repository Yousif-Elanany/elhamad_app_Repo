import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../repos/Executives_Repo.dart';
import 'executives_state.dart';


class ExecutivesCubit extends Cubit<ExecutivesState> {
  final ExecutivesRepository repository;

  ExecutivesCubit(this.repository) : super(ExecutivesInitial());

  Future<void> getExecutives(String companyId) async {
    emit(ExecutivesLoading());

    try {
      final response = await repository.getExecutives(companyId);

      emit(ExecutivesSuccess(response));
    } catch (e) {
      emit(ExecutivesError(e.toString()));
    }
  }
}
