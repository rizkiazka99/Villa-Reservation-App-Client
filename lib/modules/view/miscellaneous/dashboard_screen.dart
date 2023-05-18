import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/confirmation_dialog.dart';
import 'package:reservilla/widgets/default_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardScreenController controller = Get.find<DashboardScreenController>();

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
                const Text('Dashboard Screen'),
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
        )
      ),
    );
  }
}