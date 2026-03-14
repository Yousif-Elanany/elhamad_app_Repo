
import 'package:flutter/material.dart';

import 'CompanyCard.dart';

class CompanyInfoGrid extends StatelessWidget {
  const CompanyInfoGrid();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CompanyCard(
            label: 'رأس المال',
            value: '50,000,000',
            sub: 'الريال السعودي',
            showCurrency: true,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: CompanyCard(
            label: 'عدد الأسهم',
            value: '500,000',
            sub: 'سهم مُصدَر',
            showCurrency: false,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: CompanyCard(
            label: 'القيمة الرسمية للسهم',
            value: '100',
            sub: 'لكل سهم',
            showCurrency: true,
          ),
        ),
      ],
    );
  }
}