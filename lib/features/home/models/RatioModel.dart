import 'dart:ui';

import '../../../core/constants/app_colors.dart';
import 'SubscriptionsModel.dart';

class RatioItem {
  String title;
  int total;
  int used;
  double get percent => total == 0 ? 0 : used / total;
  Color barColor;

  RatioItem({
    required this.title,
    required this.total,
    required this.used,
    required this.barColor,
  });

  factory RatioItem.fromSubscription(SubscriptionsResponseModel sub) {
    return RatioItem(
      title: sub.featureName,
      total: sub.availableCount,
      used: sub.usageCount,
      barColor: AppColors.primaryOlive,
    );
  }
}