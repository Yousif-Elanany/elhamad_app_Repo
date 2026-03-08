import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../localization_service.dart';
import '../widgets/BoardTabContent.dart';
import '../widgets/ShareholdersTabContent.dart';

class Managementscreen extends StatefulWidget {
  const Managementscreen({super.key});

  @override
  State<Managementscreen> createState() => _ManagementscreenState();
}

class _ManagementscreenState extends State<Managementscreen> {
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
              "مجلس الإدارة",
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
                            BoardTabContent(),
                            ShareholdersTabContent(),
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
