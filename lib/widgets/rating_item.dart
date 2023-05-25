import 'package:flutter/material.dart';

class RatingItem extends StatelessWidget {
  final int index;
  final int rating;

  const RatingItem({super.key, required this.index, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      index <= rating
          ? 'assets/icons/icon_star.png'
          : 'assets/icons/icon_star_grey.png',
      width: 20,
    );
  }
}
