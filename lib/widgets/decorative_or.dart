import 'package:flutter/material.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';

Widget decorativeOr(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.8,
          child: const Divider(color: contextGrey, thickness: 1.5),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 6,
          child: Text(
            'atau',
            style: bodyMd(
              color: contextGrey,
            )
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.8,
          child: const Divider(color: contextGrey, thickness: 1.3),
        ),
      ],
    ),
  );
}