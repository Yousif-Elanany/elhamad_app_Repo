import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget stepCircle(String num, String label, bool isActive) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColors.primaryOlive : Colors.white,
          border: Border.all(
            color: isActive ? AppColors.primaryOlive : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            num,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: isActive ? Colors.black : Colors.grey,
        ),
      ),
    ],
  );
}
