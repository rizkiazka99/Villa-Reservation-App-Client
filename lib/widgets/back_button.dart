import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/widgets/custom_icon_button.dart';

Widget backButton() {
  return CustomIconButton(
    onTap: () {
      Get.back();
    },
    padding: 8,
    radius: 12,
    borderColor: backgroundColorPrimary,
    icon: Icons.arrow_back_ios_rounded,
    iconColor: contextOrange,
    iconSize: 16,
  );
}