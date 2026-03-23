import 'package:alhamd/core/constants/app_colors.dart';
import 'package:alhamd/features/managments/repos/Managment_Repo.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';
import 'package:alhamd/features/managments/viewModel/management_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/cache_helper.dart';
import '../../../../localization_service.dart';
import '../../viewModel/management_cubit.dart';
import '../widgets/BoardTabContent.dart';
import '../widgets/ShareholdersTabContent.dart';

class ManagementScreenWrapper extends StatelessWidget {
  const ManagementScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    print("🔥 CompanyHomeWrapper built");
    return BlocProvider(
      create: (_) =>
          ManagementCubit(ManagementRepository(ManagementRemoteDataSource())),
      child: const ManagementScreen(),
    );
  }
}

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  @override
  void initState() {
    super.initState();
    print("🔥 ManagementScreen initState called");
    final cubit = context.read<ManagementCubit>();
    cubit.getDirectors(CacheHelper.getData("companyId"));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: SizedBox(),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "مجلس الإدارة",
              style: TextStyle(
                color: AppColors.primaryOlive,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        indicatorColor: Color(0xFF8B8B6B),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(text: "مجلس الإدارة"),
                          Tab(text: "المساهمون"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            BoardTabContent(
                              cubit: context.read<ManagementCubit>(),
                            ),
                            ShareholdersTabContent(
                              cubit: context.read<ManagementCubit>(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
