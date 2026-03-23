import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Model/committeesResponseModel.dart';
import '../Repos/Commites_Repo.dart';

part 'committees_state.dart';

class CommitteesCubit extends Cubit<CommitteesState> {

  final CommitteesRepository repository;

  CommitteesCubit(this.repository) : super(CommitteesInitial());

  Future<void> getCommittees(String companyId) async {
    emit(GetCommitteesLoading());

    try {
      final response = await repository.getCommittees(companyId);
      emit(GetCommitteesSuccess(response));
    } catch (e) {
      emit(GetCommitteesError(e.toString()));
    }
  }
}
