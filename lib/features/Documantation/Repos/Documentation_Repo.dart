

import 'package:alhamd/features/Documantation/Models/DocumentationRequestResponseModel.dart';
import 'package:alhamd/features/Documantation/Models/DocumentationResponseModel.dart';

import '../services/Documentation_Remote_Data_Source.dart';

class DocumentationRepository implements DocumentationRemoteDataSource {
  final DocumentationRemoteDataSource remote;

  DocumentationRepository(this.remote);

  @override
  Future<DocumentationResponseModel> getDocumentation(String companyId) {
    return remote.getDocumentation(companyId);
  }

  @override
  Future<DocumentationRequestResponseModel> getDocumentationRequests(
    String companyId,
  ) {
    return remote.getDocumentationRequests(companyId);
  }
}
