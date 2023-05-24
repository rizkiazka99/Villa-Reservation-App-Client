import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final double iconSize;
  final Color? color;
  final TextStyle? textStyle;

  const ErrorState({
    super.key, 
    required this.iconSize, 
    required this.color, 
    required this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.error,
          size: iconSize,
          color: color,
        ),
        Text(
          'Terjadi Kesalahan',
          style: textStyle,
        )
      ]
    );
  }
}