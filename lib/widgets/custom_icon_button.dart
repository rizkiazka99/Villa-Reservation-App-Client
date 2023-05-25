import 'package:flutter/material.dart';
import 'package:reservilla/core/colors.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? onTap;
  final double padding;
  final double radius;
  final Color borderColor;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;

  const CustomIconButton({
    super.key,
    this.padding = 0,
    required this.onTap,
    required this.radius,
    this.borderColor = contextOrange,
    required this.icon,
    this.iconColor = contextOrange,
    this.iconSize = 25
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              width: 2, 
              color: borderColor
            )
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}