import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/DocumentationRequestResponseModel.dart';
import '../Models/DocumentationResponseModel.dart';
import '../Repos/Documentation_Repo.dart';

part 'documantation_state.dart';


class DocumentationCubit extends Cubit<DocumantationState> {
  final DocumentationRepository repository;

  DocumentationResponseModel? _cachedDocumentation;
  DocumentationRequestResponseModel? _cachedRequests;

  DocumentationCubit(this.repository) : super(DocumantationInitial());

  Future<void> getDocumentation(String companyId) async {
    emit(DocumentationLoading());
    try {
      final response = await repository.getDocumentation(companyId);
      _cachedDocumentation = response;
      emit(DocumentationSuccess(response));  // ← مباشرة بدون _cachedDocumentation!
    } catch (e) {
      emit(DocumentationError(e.toString()));
    }
  }

  Future<void> getDocumentationRequests(String companyId) async {
    emit(DocumentationRequestsLoading());
    try {
      final response = await repository.getDocumentationRequests(companyId);
      _cachedRequests = response;
      emit(DocumentationRequestsSuccess(response));  // ← مباشرة بدون _cachedRequests!
    } catch (e) {
      emit(DocumentationRequestsError(e.toString()));
    }
  }

  DocumentationResponseModel? get cachedDocumentation => _cachedDocumentation;
  DocumentationRequestResponseModel? get cachedRequests => _cachedRequests;
}