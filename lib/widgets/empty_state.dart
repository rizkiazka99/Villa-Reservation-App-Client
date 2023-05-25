import 'package:flutter/material.dart';
import 'package:reservilla/core/font_sizes.dart';

class EmptyState extends StatelessWidget {
  final double height;
  final String imageAsset;
  final double imageHeight;
  final double imageWidth;
  final String message;
  
  const EmptyState({
    super.key, 
    required this.height, 
    required this.imageAsset,
    this.imageHeight = 250, 
    this.imageWidth = 250, 
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              height: imageHeight,
              width: imageWidth,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: bodyLg(fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}