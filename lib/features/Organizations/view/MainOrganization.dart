import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../localization_service.dart';
import '../../../core/network/cache_helper.dart';
import '../Repos/Organization_Repo.dart';
import '../Services/organization_Remote_Data_Source.dart';
import '../ViewModel/organization_cubit.dart';
import 'OrganizationRequests.dart';
import 'Organizations.dart';


class MainOrganizationScreenWrapper extends StatelessWidget {
  const MainOrganizationScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    print("🔥 CompanyHomeWrapper built");
    return BlocProvider(
      create: (_) =>
          OrganizationCubit(OrganizationRepository(OrganizationRemoteDataSource()))..getCompanyMeetings(CacheHelper.getData("companyId"))..getCompanyMeetingsRequests(CacheHelper.getData("companyId")),
      child: const MainOrganizationScreen(),
    );
  }
}


class MainOrganizationScreen extends StatefulWidget {
  const MainOrganizationScreen({super.key});

  @override
  State<MainOrganizationScreen> createState() => _MainOrganizationScreenState();
}

class _MainOrganizationScreenState extends State<MainOrganizationScreen> {
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
              "organizations".tr(),
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
                          Tab(text: "organizations".tr()),
                          Tab(text: "requests_meeting".tr()),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [Organizations(
                            cubit:  context.read<OrganizationCubit>(),
                          ), OrganizationRequest(

                            cubit:  context.read<OrganizationCubit>(),

                          )],
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
