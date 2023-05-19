import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/modules/controller/contents/profile_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/confirmation_dialog.dart';
import 'package:reservilla/widgets/default_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenController controller = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Profile Screen'),
                DefaultButton(
                  onTap: () {
                    Get.dialog(
                      ConfirmationDialog(
                        title: 'Tunggu sebentar!', 
                        content: 'Apakah Anda yakin ingin keluar dari akun Anda?', 
                        onConfirmation: () async {
                          await controller.logout();
                          Get.offAllNamed(loginScreenRoute);
                        }
                      )
                    );
                  }, 
                  color: contextRed, 
                  buttonText: 'Keluar'
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}