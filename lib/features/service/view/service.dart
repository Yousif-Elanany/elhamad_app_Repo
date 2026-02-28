import 'package:flutter/material.dart';
import '../../home/view/widgets/appdrawer.dart';
import '../../../localization_service.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationService.getLang() == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      drawer: const Appdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "services".tr(),
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            // Grid للكروت
            SliverGrid(
              delegate: SliverChildListDelegate([
                _buildServiceCard("associations".tr(), Icons.business_outlined, 12, () {
                  Navigator.pushNamed(context, "/organizations");
                }),
                _buildServiceCard("board_of_directors".tr(), Icons.groups_outlined, 8, () {}),
                _buildServiceCard("committees".tr(), Icons.folder_open_outlined, 15, () {}),
                _buildServiceCard("committees".tr(), Icons.folder_open_outlined, 15, () {}),
                _buildServiceCard("Executives/Administrators".tr(), Icons.folder_open_outlined, 15, () {
                  Navigator.pushNamed(context, "/ExecutivesAdministrators");


                }),

                _buildServiceCard("decisions".tr(), Icons.description_outlined, 24, () {}),
                _buildServiceCard("contracts".tr(), Icons.assignment_outlined, 6, () {}),
                _buildServiceCard("messages_support".tr(), Icons.chat_bubble_outline, 10, () {}),
                _buildServiceCard("policies_regulations".tr(), Icons.book, 3, () {

                  Navigator.pushNamed(context, "/Rule");


                }),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),

            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 180,
            //     width: double.infinity,
            //     child:
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, IconData icon, int count, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Colors.grey[600]),
                  const SizedBox(height: 12),
                  FittedBox(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFF8B8E75),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$count",
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
