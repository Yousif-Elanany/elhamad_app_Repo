import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Model/PolicyRequestDetailModel.dart';
import '../Model/PolicyResponseModel.dart';
import '../Model/makeRequestPolicy.dart';
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
      emit(
        PolicyBothSuccess(policies: _cachedPolicies, requests: _cachedRequests),
      );
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
      emit(
        PolicyBothSuccess(policies: _cachedPolicies, requests: _cachedRequests),
      );
    } catch (e) {
      emit(PolicyError(e.toString()));
    }
  }

  /// ================= CREATE =================
  Future<void> createPoliciesRequests(String companyId,
      CreateModelRequestModel model,) async {
    emit(CreatePolicyRequestLoading());

    try {
      await repository.createPoliciesRequests(companyId, model);

      emit(CreatePolicyRequestSuccess());

      fetchPoliciesRequests(companyId);
      // نعمل refresh للـ requests بس
    } catch (e) {
      emit(CreatePolicyRequestError(e.toString()));
    }
  }

  /// ================= DELETE =================
  Future<void> deletePoliciesRequests(String companyId, int policyId) async {
    emit(DeletePolicyRequestLoading());

    try {
      await repository.deletePoliciesRequests(companyId, policyId);

      emit(DeletePolicyRequestSuccess());
    } catch (e) {
      emit(DeletePolicyRequestError(e.toString()));
    }
  }

  /// ================= EDIT =================
  Future<void> editPoliciesRequestById(String companyId,
      CreateModelRequestModel model,
      int policyId,) async {
    emit(EditPolicyRequestLoading());

    try {
      await repository.editPoliciesRequestById(companyId, model, policyId);

      emit(EditPolicyRequestSuccess());

      // refresh request list
      await fetchPoliciesRequests(companyId);
    } catch (e) {
      emit(EditPolicyRequestError(e.toString()));
    }
  }

  /// ================= GET BY ID =================
  Future<void> getPoliciesRequestById(String companyId, int policyId) async {
    emit(GetPolicyRequestByIdLoading());

    try {
      final response = await repository.getPoliciesRequestById(
        companyId,
        policyId,
      );

      emit(GetPolicyRequestByIdSuccess(response));
    } catch (e) {
      emit(GetPolicyRequestByIdError(e.toString()));
    }
  }
}
