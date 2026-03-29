import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetingCard extends StatelessWidget {
  final DateTime startTime;
  final String location;       // "عن بعد" أو اسم المكان
  final String? link;
  final String? assignedBy;    // "محدد بواسطتك"
  final int firstQuorumPercentage;
  final int secondQuorumPercentage;
  final int currentAttempt;
  final int totalAttempts;
  final VoidCallback onDetailsTap;

  const MeetingCard({
    Key? key,
    required this.startTime,
    required this.location,
    this.link,
    this.assignedBy,
    required this.firstQuorumPercentage,
    required this.secondQuorumPercentage,
    required this.currentAttempt,
    required this.totalAttempts,
    required this.onDetailsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── اليمين: التاريخ ──
          _buildDateSection(),
          const SizedBox(width: 12),
          const VerticalDivider(width: 1, thickness: 0.5),
          const SizedBox(width: 12),

          // ── المنتصف: التفاصيل ──
          Expanded(child: _buildDetailsSection()),
          const SizedBox(width: 12),

          // ── اليسار: الحالة والنصاب ──
          _buildRightSection(context),
        ],
      ),
    );
  }

  // ── قسم التاريخ ──
  Widget _buildDateSection() {
    final dayName = _getDayName(startTime.weekday);
    final day = startTime.day.toString();
    final month = _getMonthName(startTime.month);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          dayName,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          day,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          month,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  // ── قسم التفاصيل ──
  Widget _buildDetailsSection() {
    final timeFormatted =
        "${_getDayName(startTime.weekday)}، ${startTime.day} ${_getMonthName(startTime.month)} ${startTime.year} في "
        "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} "
        "${startTime.hour < 12 ? 'ص' : 'م'}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الوقت
        Row(
          children: [
            const Icon(Icons.access_time, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                timeFormatted,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // المكان
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              location,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // الرابط
        if (link != null && link!.isNotEmpty)
          Row(
            children: [
              const Icon(Icons.link, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  link!.length > 25 ? "${link!.substring(0, 25)}..." : link!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  // ── قسم الأيمن ──
  Widget _buildRightSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // محدد بواسطتك
        if (assignedBy != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              assignedBy!,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
        const SizedBox(height: 8),

        // بادج النصاب
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF7D7D3C),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                "النصاب الطلوب: %$firstQuorumPercentage.00",
                style: const TextStyle(fontSize: 10, color: Color(0xFFE8E8B8)),
              ),
              Text(
                "الحالي: %$secondQuorumPercentage.00",
                style: const TextStyle(fontSize: 10, color: Color(0xFFE8E8B8)),
              ),
              Text(
                "عقد اجتماع $currentAttempt/$totalAttempts",
                style: const TextStyle(fontSize: 10, color: Color(0xFFE8E8B8)),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 8),
        //
        // // زر التفاصيل
        // GestureDetector(
        //   onTap: onDetailsTap,
        //   child: Container(
        //     width: 36,
        //     height: 36,
        //     decoration: BoxDecoration(
        //       border: Border.all(color: Colors.grey.shade300),
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //     child: const Icon(Icons.remove_red_eye_outlined,
        //         size: 18, color: Colors.grey),
        //   ),
        // ),
      ],
    );
  }

  String _getDayName(int weekday) {
    const days = ["الاثنين","الثلاثاء","الأربعاء","الخميس","الجمعة","السبت","الأحد"];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = ["يناير","فبراير","مارس","أبريل","مايو","يونيو",
      "يوليو","أغسطس","سبتمبر","أكتوبر","نوفمبر","ديسمبر"];
    return months[month - 1];
  }
}