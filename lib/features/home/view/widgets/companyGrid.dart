
import 'package:flutter/material.dart';

import 'CompanyCard.dart';
class CompanyInfoGrid extends StatelessWidget {
  final int capitalAmount;
  final int shareCount;
  final int nominalShareValue;

  const CompanyInfoGrid({
    super.key,
    required this.capitalAmount,
    required this.shareCount,
    required this.nominalShareValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CompanyCard(
            label: 'رأس المال',
            value: capitalAmount.toString(),
            sub: 'الريال السعودي',
            showCurrency: true,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: CompanyCard(
            label: 'عدد الأسهم',
            value: shareCount.toString(),
            sub: 'سهم مُصدَر',
            showCurrency: false,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: CompanyCard(
            label: 'القيمة الرسمية للسهم',
            value: nominalShareValue.toString(),
            sub: 'لكل سهم',
            showCurrency: true,
          ),
        ),
      ],
    );
  }
}