import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../localization_service.dart';
import '../model/organization_model.dart';

Widget buildOrgCard(Organization? org) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "pending".tr(),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    org?.name ?? "meeting_name".tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "09:00 - 09:30",
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        org?.description ?? "zoom_meeting".tr(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(Icons.link, size: 14, color: Colors.blue),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "https://zoom.us/j/7159138385",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            width: 20,
            thickness: 1,
            color: Colors.grey.shade200,
            indent: 15,
            endIndent: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "thursday".tr(),
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
                const Text(
                  "27",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

