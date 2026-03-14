import 'dart:ui';

class RatioItem {
  final String title;
  final int total;
  final int used;
  final Color barColor;

  const RatioItem({
    required this.title,
    required this.total,
    required this.used,
    required this.barColor,
  });

  double get percent => total == 0 ? 0 : used / total;
}