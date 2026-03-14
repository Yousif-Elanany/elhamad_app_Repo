
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CompanyCard extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final bool showCurrency;

  const CompanyCard({
    required this.label,
    required this.value,
    required this.sub,
    required this.showCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      // padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryOlive,
            ),
          ),
          const SizedBox(height: 10),

          FittedBox(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                overflow: TextOverflow.ellipsis,
                letterSpacing: -0.5,
              ),
            ),
          ),

          const SizedBox(height: 4),
          if (showCurrency) ...[
            const SizedBox(width: 10),
            Text(
              '﷼',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryOlive,
              ),
            ),
          ],
          // Text(
          //   sub,
          //   style:  TextStyle(fontSize: 12, color: AppColors.primaryOlive,),
          // ),
        ],
      ),
    );
  }
}