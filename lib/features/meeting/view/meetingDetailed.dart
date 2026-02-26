import 'package:flutter/material.dart';

import '../../../localization_service.dart';

class MeetingDetailsPage extends StatelessWidget {
  const MeetingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAr = LocalizationService.getLang() == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            isAr ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "meeting_details".tr(),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          // CrossAxisAlignment.start يتغير تلقائياً حسب اللغة
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(isAr),
            const SizedBox(height: 20),

            _buildSectionTitle("agenda".tr()),
            _buildAgendaSection(),
            const SizedBox(height: 20),

            _buildSectionTitle("attendees".tr()),
            _buildAttendeesSection(isAr),
            const SizedBox(height: 20),

            _buildSectionTitle("attachments".tr()),
            _buildAttachmentsSection(isAr),
            const SizedBox(height: 30),

            _buildActionButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildInfoCard(bool isAr) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "general_assembly".tr(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff86896E)),
          ),
          const SizedBox(height: 15),
          _buildInfoRow(isAr ? "21 يناير 2025" : "21 January 2025", Icons.calendar_today_outlined),
          _buildInfoRow(isAr ? "09:00 صباحاً" : "09:00 AM", Icons.access_time),
          _buildInfoRow("meeting_link_zoom".tr(), Icons.videocam_outlined, isLink: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String text, IconData icon, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: isLink ? Colors.blue : Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildAgendaSection() {
    List<String> items = [
      "agenda_item_1".tr(),
      "agenda_item_2".tr(),
      "agenda_item_3".tr(),
      "agenda_item_4".tr(),
      "agenda_item_5".tr(),
      "agenda_item_6".tr()
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.circle, size: 6, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildAttendeesSection(bool isAr) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: List.generate(3, (index) => ListTile(
          leading: const CircleAvatar(
              backgroundColor: Color(0xFFF0F2F5),
              child: Icon(Icons.person, color: Colors.grey)
          ),
          title: Text(
              isAr ? "أحمد بن علي" : "Ahmed Bin Ali",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
          ),
          subtitle: Text(
              "chairman".tr(),
              style: const TextStyle(fontSize: 12, color: Colors.grey)
          ),
        )),
      ),
    );
  }

  Widget _buildAttachmentsSection(bool isAr) {
    return Column(
      children: List.generate(3, (index) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("financial_report".tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const Text("2.4 MB", style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.download_outlined, color: Colors.grey),
          ],
        ),
      )),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff86896E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {},
            child: Text(
              "join_meeting".tr(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: Text(
            "add_to_calendar".tr(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}