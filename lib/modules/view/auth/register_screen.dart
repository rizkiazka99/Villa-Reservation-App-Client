import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/auth/register_screen_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenController controller = Get.find<RegisterScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}