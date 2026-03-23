import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Model/PolicyResponseModel.dart';
import '../Model/policiesRequestResponseModel.dart';
import '../Repos/Policy_Repo.dart';

part 'policy_state.dart';
class PolicyCubit extends Cubit<PolicyState> {
  final PolicyRepository repository;

  // حفظ البيانات محلياً عشان متتمسحش عند تغيير التاب
  PoliciesResponseModel? _cachedPolicies;
  PoliciesRequestResponseModel? _cachedRequests;

  PolicyCubit(this.repository) : super(PolicyInitial());

  /// جلب السياسات
  Future<void> fetchPolicies(String companyId) async {
    emit(PolicyPoliciesLoading());
    try {
      final response = await repository.getPolicies(companyId);
      _cachedPolicies = response;
      emit(PolicyBothSuccess(
        policies: _cachedPolicies,
        requests: _cachedRequests,
      ));
    } catch (e) {
      emit(PolicyError(e.toString()));
    }
  }

  /// جلب طلبات السياسات
  Future<void> fetchPoliciesRequests(String companyId) async {
    emit(PolicyRequestsLoading());
    try {
      final response = await repository.getPoliciesRequests(companyId);
      _cachedRequests = response;
      emit(PolicyBothSuccess(
        policies: _cachedPolicies,
        requests: _cachedRequests,
      ));
    } catch (e) {
      emit(PolicyError(e.toString()));
    }
  }
}