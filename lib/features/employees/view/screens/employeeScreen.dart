import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../localization_service.dart';
import '../../../managments/views/widgets/BoardTabContent.dart';
import '../../../managments/views/widgets/ShareholdersTabContent.dart';
import 'EmployeesTabContent.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
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
            ),],
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "الموظفين",
              style:  TextStyle(
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
                  length: 1,
                  child: Column(
                    children: [
                      TabBar(
                        indicatorColor: Color(0xFF8B8B6B),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(text: "الموظفين"),
                        //  Tab(text: "الصلاحيات"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            EmployeesTabContent(),
                           // ShareholdersTabContent(),
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
