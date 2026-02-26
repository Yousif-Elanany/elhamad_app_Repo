import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final double iconSize;
  final double borderRadius;
  final EdgeInsets padding;

  const ActionIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
    this.iconSize = 18,
    this.borderRadius = 8,
    this.padding =
    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}