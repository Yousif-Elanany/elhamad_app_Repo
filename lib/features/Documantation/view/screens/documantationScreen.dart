import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../../localization_service.dart';
import '../../../drawer/appdrawer.dart';
import '../../../policy/views/widgets/add_policyCard.dart';
import '../../Repos/Documentation_Repo.dart';
import '../../services/Documentation_Remote_Data_Source.dart';
import '../../viewModels/documantation_cubit.dart';
import '../widgets/documntation_request_card.dart';
import '../widgets/requestDialog.dart';

class DocumentationScreenWrapper extends StatelessWidget {
  const DocumentationScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DocumentationCubit(
        DocumentationRepository(DocumentationRemoteDataSource()),
      ),
      child: const DocumentationScreen(),
    );
  }
}

class DocumentationScreen extends StatefulWidget {
  const DocumentationScreen({super.key});

  @override
  State<DocumentationScreen> createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // نادي requests عند الدخول
    context.read<DocumentationCubit>().getDocumentationRequests(
      CacheHelper.getData("companyId"),
    );

    // اسمع للتغيير بين التابين
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      final companyId = CacheHelper.getData("companyId");

      if (_tabController.index == 0) {
        context.read<DocumentationCubit>().getDocumentationRequests(companyId);
      } else if (_tabController.index == 1) {
        context.read<DocumentationCubit>().getDocumentation(companyId);
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
          "documentation".tr(),
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
            Tab(text: "Documentation_requests".tr()),
            Tab(text: "documentation".tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          /// 🔹 التاب الأول (طلبات التوثيق)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => showDocumentRequestDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOlive,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  label: Text(
                    "Documentation_requests".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<DocumentationCubit, DocumantationState>(
                  builder: (context, state) {
                    // Loading خاص بالـ requests
                    if (state is DocumentationRequestsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DocumentationRequestsError) {
                      print("Error State: ${state.message}");
                      return Center(
                        child: Text(
                          "حدث خطأ: ${state.message}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    // عرض البيانات من الـ state أو الكاش
                    final requests = state is DocumentationRequestsSuccess
                        ? state.data.items
                        : context.read<DocumentationCubit>().cachedRequests?.items ?? [];

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
                          child: documatationRequestCard(
                            index: item.id,
                            complainant: item.requestedByName,
                            content: item.notes,
                            date: DateFormat('yyyy/MM/dd – hh:mm a')
                                .format(item.createdAt),
                            type: item.type,
                            status: item.status,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          /// 🔹 التاب الثاني (التوثيق)
          Column(
            children: [
              Expanded(
                child: BlocBuilder<DocumentationCubit, DocumantationState>(
                  builder: (context, state) {
                    // Loading خاص بالـ documentation
                    if (state is DocumentationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DocumentationError) {
                      return Center(
                        child: Text(
                          "حدث خطأ: ${state.message}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    // عرض البيانات من الـ state أو الكاش
                    final docs = state is DocumentationSuccess
                        ? state.data.items
                        : context.read<DocumentationCubit>().cachedDocumentation?.items ?? [];

                    if (docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "لا توجد وثائق",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final item = docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AddPolicyCard(
                            index: int.tryParse(item.id) ?? 0,
                            address: item.companyName,
                            bySomeOne: item.creatorName,
                            creationDate: DateFormat('yyyy/MM/dd – hh:mm a')
                                .format(item.createdAt),
                          ),
                        );
                      },
                    );
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