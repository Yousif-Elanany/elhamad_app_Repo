import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../../localization_service.dart';
import '../../../drawer/appdrawer.dart';
import '../../Repos/Policy_Repo.dart';
import '../../sevices/Policy_Remote_Data_Source.dart';
import '../../viewModel/policy_cubit.dart';
import '../widgets/AddPolicyDialog.dart';
import '../widgets/add_policyCard.dart';
import '../widgets/makePolicyRequestDialog.dart';
import '../widgets/policyCard.dart';

class RulesAndRegulationsScreenWrapper extends StatelessWidget {
  const RulesAndRegulationsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PolicyCubit(PolicyRepository(PolicyRemoteDataSource())),
      child: const RulesAndRegulations(),
    );
  }
}

class RulesAndRegulations extends StatefulWidget {
  const RulesAndRegulations({super.key});

  @override
  State<RulesAndRegulations> createState() => _RulesAndRegulationsState();
}

class _RulesAndRegulationsState extends State<RulesAndRegulations>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // نادي requests عند الدخول
    context.read<PolicyCubit>().fetchPoliciesRequests(
      CacheHelper.getData("companyId"),
    );

    // اسمع للتغيير بين التابين
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      final companyId = CacheHelper.getData("companyId");

      if (_tabController.index == 0) {
        context.read<PolicyCubit>().fetchPoliciesRequests(companyId);
      } else if (_tabController.index == 1) {
        context.read<PolicyCubit>().fetchPolicies(companyId);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Appdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        centerTitle: true,
        title: Text(
          "policies_regulations".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryOlive,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryOlive,
          tabs: [
            Tab(text: "Policy_Requests".tr()),
            Tab(text: "Policies".tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          /// 🔹 التاب الأول (طلبات السياسات)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => AddPolicyRequestDialog.show(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOlive,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  label: Text(
                    "add_policy".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<PolicyCubit, PolicyState>(
                  builder: (context, state) {
                    // Loading خاص بالـ requests بس
                    if (state is PolicyRequestsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is PolicyError) {
                      return Center(
                        child: Text(
                          "حدث خطأ: ${state.message}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state is PolicyBothSuccess) {
                      final requests = state.requests?.items ?? [];

                      if (requests.isEmpty) {
                        return const Center(
                          child: Text(
                            "لا توجد طلبات",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final item = requests[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: PolicyCard(
                              index: item.id,
                              companyName: item.companyName,
                              address: item.title,
                              Status: item.status,
                              notes: item.notes,
                              makeRequest: item.requestedByName,
                              date: DateFormat('yyyy/MM/dd – hh:mm a')
                                  .format(item.createdAt),
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),

          /// 🔹 التاب الثاني (السياسات)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => AddPolicyRequestDialog.show(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOlive,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  label: Text(
                    "add_policy".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<PolicyCubit, PolicyState>(
                  builder: (context, state) {
                    // Loading خاص بالـ policies بس
                    if (state is PolicyPoliciesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is PolicyError) {
                      return Center(
                        child: Text(
                          "حدث خطأ: ${state.message}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state is PolicyBothSuccess) {
                      final policies = state.policies?.items ?? [];

                      if (policies.isEmpty) {
                        return const Center(
                          child: Text(
                            "لا توجد سياسات",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: policies.length,
                        itemBuilder: (context, index) {
                          final item = policies[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: AddPolicyCard(
                              index: item.id,
                              address: item.companyName,
                              bySomeOne: item.creatorName,
                              creationDate: DateFormat('yyyy/MM/dd – hh:mm a')
                                  .format(item.createdAt),
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}