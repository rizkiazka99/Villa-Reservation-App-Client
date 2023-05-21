import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.7,
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