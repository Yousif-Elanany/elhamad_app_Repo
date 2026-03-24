import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Models/DocumentationRequestResponseModel.dart';
import '../Models/DocumentationResponseModel.dart';

class DocumentationRemoteDataSource {

    ///// جلب معلومات الشركة
  Future<DocumentationResponseModel> getDocumentation(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/decision-documents",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return DocumentationResponseModel.fromJson(response.data);
  }

  Future<DocumentationRequestResponseModel> getDocumentationRequests(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/decision-document-requests",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return DocumentationRequestResponseModel.fromJson(response.data);
  }


}
