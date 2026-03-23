part of 'committees_cubit.dart';

@immutable
sealed class CommitteesState {}

final class CommitteesInitial extends CommitteesState {}


final class GetCommitteesLoading extends CommitteesState {}

final class GetCommitteesSuccess extends CommitteesState {
  final CommitteesResponseModel data;

  GetCommitteesSuccess(this.data);
}

final class GetCommitteesError extends CommitteesState {
  final String error;

  GetCommitteesError(this.error);
}
