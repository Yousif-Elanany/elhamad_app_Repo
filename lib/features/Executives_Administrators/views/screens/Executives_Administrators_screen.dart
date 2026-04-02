import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../../localization_service.dart';
import '../../../home/models/complainModel.dart';
import '../../../drawer/appdrawer.dart';
import '../../Services/Executives_Remote_Data_Source.dart';
import '../../repos/Executives_Repo.dart';
import '../../viewModel/executives_cubit.dart';
import '../../viewModel/executives_state.dart';
import '../widgets/AdminstraationDialog.dart';
import '../widgets/adminCard.dart';

class ExecutivesAdministratorsScreenWrapper extends StatelessWidget {
  const ExecutivesAdministratorsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    print("🔥 CompanyHomeWrapper built");
    return BlocProvider(
      create: (_) =>
          ExecutivesCubit(ExecutivesRepository(ExecutivesRemoteDataSource())),
      child: const ExecutivesAdministrators(),
    );
  }
}

class ExecutivesAdministrators extends StatefulWidget {
  const ExecutivesAdministrators({super.key});

  @override
  State<ExecutivesAdministrators> createState() =>
      _ExecutivesAdministratorsState();
}

class _ExecutivesAdministratorsState extends State<ExecutivesAdministrators> {
  @override
  void initState() {
    super.initState();
    context.read<ExecutivesCubit>().getExecutives(
      CacheHelper.getData("companyId"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExecutivesCubit, ExecutivesState>(
      listener: (context, state) {
        final cubit = context.read<ExecutivesCubit>();

        /// ✅ SUCCESS
        if (state is CreateExecutiveSuccess ||
            state is EditExecutiveSuccess ||
            state is DeleteExecutiveSuccess) {
          Navigator.pop(context);

          String message = "";

          if (state is CreateExecutiveSuccess) {
            message = "تم إنشاء مجلس الإدارة بنجاح";
          } else if (state is EditExecutiveSuccess) {
            message = "تم تعديل مجلس الإدارة بنجاح";
          } else if (state is DeleteExecutiveSuccess) {
            message = "تم حذف مجلس الإدارة بنجاح";
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.primaryOlive,
            ),
          );

          cubit.getExecutives(CacheHelper.getData("companyId"));
        }
        if (state is SendSignatureSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("تم إرسال طلب التوقيع بنجاح"),
              backgroundColor: AppColors.primaryOlive,
            ),
          );
          cubit.getExecutives(CacheHelper.getData("companyId"));
        }

        /// ❌ ERROR
        if (state is DeleteExecutiveError) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );

          cubit.getExecutives(CacheHelper.getData("companyId"));
        }
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Appdrawer(),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          title: Text(
            "Executives/Administrators".tr(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              /// 🔹 زر الإضافة
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: context.read<ExecutivesCubit>(),
                            child: const AddContributorDialog(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOlive,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: Text(
                        "Executive/Administrative Addition".tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// 🔹 القائمة
              Expanded(
                child: BlocBuilder<ExecutivesCubit, ExecutivesState>(
                  builder: (context, state) {
                    /// ⏳ Loading
                    if (state is ExecutivesLoading ||
                        state is CreateExecutiveLoading ||
                        state is EditExecutiveLoading ||
                        state is DeleteExecutiveLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    /// ✅ Success
                    if (state is ExecutivesSuccess) {
                      final items = state.data.items;

                      if (items.isEmpty) {
                        return const Center(child: Text("لا يوجد بيانات"));
                      }

                      final cubit = context.read<ExecutivesCubit>();

                      return ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: adminCard(
                              index: item.profileId,
                              email: item.phone,
                              name: item.name,
                              cubit: cubit,
                              signatureRequestId: item.userId,
                              NationalID: item.nationalId,
                              jobTitle: item.jobTitle,
                              isActive: item.isActive,
                              status: item.signatureStatus,
                              phone: item.phone,
                            ),
                          );
                        },
                      );
                    }

                    /// ❌ Error
                    if (state is ExecutivesError) {
                      return Center(child: Text(state.message));
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}