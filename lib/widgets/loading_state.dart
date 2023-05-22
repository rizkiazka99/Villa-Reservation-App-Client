import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';

class LoadingState extends StatelessWidget {
  final double height;

  const LoadingState({
    super.key, 
    required this.height 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitRing(
            color: contextOrange,
            size: 45,
          ),
          const SizedBox(width: 15),
          Text(
            'Memuat...',
            style: h4(),
          )
        ],
      )
    );
  }
}