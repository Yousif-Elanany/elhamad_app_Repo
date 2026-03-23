import '../../massages/Models/MassageResponseModel.dart';
import '../Model/ContactUsModel.dart';
import '../Services/Contact_Remote_Data_Source.dart';


class ContactRepository implements ContactRemoteDataSource {
  final ContactRemoteDataSource remote;

  ContactRepository(this.remote);


  @override
  Future<ContactUsResponseModel> getContactUs(String companyId) {
    return remote.getContactUs(companyId);
  }

  // @override
  // Future<Map<String, dynamic>> loginWithSms(String nationalId) async {
  //   return remote.loginWithSms(nationalId);
  // }
}
