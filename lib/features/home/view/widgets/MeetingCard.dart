import 'package:flutter/material.dart';

Widget buildMeetingCard(
    String title,
    String date,
    String time,
    String status, {
      bool isComplete = false,
      required bool isArabic,
    }) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: Container(
      // الكونتينر اللي ضفته
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isComplete ? Colors.green[50] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isComplete ? Colors.green : Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
            ],
          ),
          const Divider(height: 24),
          const Text(
            "https://us04web.zoom.us/...",
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
