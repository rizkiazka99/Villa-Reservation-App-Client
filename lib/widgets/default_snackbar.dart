import 'package:flutter/material.dart';
import 'package:get/get.dart';

defaultSnackbar(String title, String message) {
  Get.snackbar(
    title, 
    message,
    backgroundColor: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(20),
    borderRadius: 20,
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3)
      )
    ]
  );
}