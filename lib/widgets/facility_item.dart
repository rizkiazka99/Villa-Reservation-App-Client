import 'package:flutter/material.dart';
import 'package:reservilla/core/theme.dart';

class FacilityItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String total;

  const FacilityItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
          width: 32,
        ),
        SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
            text: "$total",
            style: greyTextStyle.copyWith(
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: name != 'Pool' ? ' $name' : '',
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
