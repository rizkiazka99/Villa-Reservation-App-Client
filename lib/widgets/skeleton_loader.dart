import 'package:flutter/material.dart';
import 'package:reservilla/core/colors.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLoader extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonLoader({Key? key, this.height = 125, this.width = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width == 0 ? MediaQuery.of(context).size.width : width,
      margin: EdgeInsets.only(
          top: width == 120 || width == 147 ? 0 : 12,
          bottom: width == 120 ? 12 : 0,
          left: 12,
          right: 12),
      child: SkeletonAnimation(
        shimmerColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        shimmerDuration: 1000,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: backgroundColorPrimary
              )
            ],
          ),
        ),
      ),
    );
  }
}