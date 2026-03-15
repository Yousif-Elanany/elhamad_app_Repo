import 'package:alhamd/features/home/repo/home_Repo.dart';
import 'package:alhamd/features/home/services/home_Remote_Data_Source.dart';
import 'package:alhamd/features/home/viewModel/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../localization_service.dart';
import '../../../drawer/appdrawer.dart';
import '../../models/RatioModel.dart';
import '../widgets/CompanyCard.dart';
import '../widgets/MeetingCard.dart';
import '../widgets/RatioCard.dart';
import '../widgets/companyGrid.dart';

class CompanyHomeWrapper extends StatelessWidget {
  const CompanyHomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    print("🔥 CompanyHomeWrapper built");
    return BlocProvider(
      create: (_) => HomeCubit(HomeRepository(HomeRemoteDataSource())),
      child: const CompanyHomePage(),
    );
  }
}

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({super.key});

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Load home data when the widget is first created
    final homeCubit = context.read<HomeCubit>();
    homeCubit.loadHomeData();
    // homeCubit.getSubscriptions(homeCubit.nationalId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationService.getLang() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textDark),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text(
                "company_name".tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "company_type".tr(),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () => Navigator.pushNamed(context, '/notification'),
              ),
            ),
          ],
        ),
        drawer: const Appdrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: isArabic
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Text(
                //   "overview".tr(),
                //   style: const TextStyle(fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: 12),
                // Row(
                //   children: [
                //     _buildStatCard(
                //       "upcoming_meetings".tr(),
                //       "3",
                //       Icons.calendar_month_outlined,
                //       Colors.green,
                //       isArabic,
                //     ),
                //     const SizedBox(width: 8),
                //     _buildStatCard(
                //       "pending_decisions".tr(),
                //       "5",
                //       Icons.verified_outlined,
                //       Colors.orange,
                //       isArabic,
                //     ),
                //     const SizedBox(width: 8),
                //     _buildStatCard(
                //       "contracts".tr(),
                //       "12",
                //       Icons.insert_drive_file_outlined,
                //       Colors.blue,
                //       isArabic,
                //     ),
                //   ],
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'ملخص الاستخدام والاستحقاق',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOlive,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryOlive,
                          strokeWidth: 4,
                        ),
                      );
                    } else if (state is HomeSuccess) {
                      final cubit = context.read<HomeCubit>();

                      final ratios = cubit.subscriptions ?? [];

                      return Column(
                        children: ratios
                            .map(
                              (r) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: RatioCard(item: r),
                              ),
                            )
                            .toList(),
                      );
                    } else if (state is SubscriptionsFailure) {
                      return Center(
                        child: Text(
                          "حدث خطأ في الاشتراكات: ${state.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 8),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(
                      0.1,
                    ), // غيّر اللون حسب الحاجة
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'معلومات الشركة:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOlive,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryOlive,
                          strokeWidth: 4,
                        ),
                      );
                    }

                    if (state is HomeSuccess) {
                      final cubit = context.read<HomeCubit>();
                      final company = cubit.companyInfo!;

                      return CompanyInfoGrid(
                        capitalAmount: company.capitalAmount,
                        shareCount: company.shareCount,
                        nominalShareValue: company.nominalShareValue,
                      );
                    }

                    if (state is HomeFailure) {
                      return const Text("حدث خطأ");
                    }

                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 24),
                // داخل Column اللي تحت Upcoming Meetings
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "upcoming_meetings".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        // احنا محتاجين نعرف هل في اجتماعات ولا لأ
                        bool hasMeetings = false;
                        if (state is MeetingTodaySuccess &&
                            state.data.meetings.isNotEmpty) {
                          hasMeetings = true;
                        }

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryOlive.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              if (hasMeetings) {
                                Navigator.pushNamed(context, '/meeting');
                              } else {
                                Fluttertoast.showToast(
                                  msg: "لا يوجد اجتماعات للعرض",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: AppColors.primaryOlive,
                                  textColor: Colors.white,
                                );
                              }
                            },
                            child: Text(
                              "view_all".tr(),
                              style: TextStyle(
                                color: AppColors.primaryOlive,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // BlocBuilder يبقى بس للعرض الفعلي للاجتماعات أو الرسالة
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is MeetingTodayLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is MeetingTodaySuccess) {
                      final meetings = state.data.meetings;

                      if (meetings.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              "لا يوجد اجتماعات",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: meetings.map((meeting) {
                          return buildMeetingCard(
                            meeting.title,
                            meeting.date,
                            meeting.time,
                            meeting.status,
                            isComplete: meeting.isComplete,
                            isArabic: LocalizationService.getLang() == 'ar',
                          );
                        }).toList(),
                      );
                    } else if (state is MeetingTodayFailure) {
                      return Center(
                        child: Text(
                          "حدث خطأ: ${state.error}",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      // لو الحالة الافتراضية (قبل أي تحميل)، ممكن نعرض placeholder بسيط
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            "لا يوجد اجتماعات",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color iconColor,
    bool isArabic,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: isArabic
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Align(
              alignment: isArabic ? Alignment.topRight : Alignment.topLeft,
              child: Icon(icon, color: iconColor.withOpacity(0.5), size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Ratio Card ─────────────────────────────────────────────────
