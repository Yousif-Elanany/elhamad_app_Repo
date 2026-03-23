import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Model/ContactUsModel.dart';
import '../Repos/contactUs.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final ContactRepository repository;

  ContactUsCubit(this.repository) : super(ContactUsInitial());

  Future<void> getComplaints(String companyId) async {
    try {
      emit(ContactUsLoading());

      final data = await repository.getContactUs(companyId);

      emit(ContactUsSuccess(data));
    } catch (e) {
      emit(ContactUsFailure(e.toString()));
    }
  }
}
