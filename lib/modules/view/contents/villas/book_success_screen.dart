import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/modules/controller/contents/villas/book_success_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/default_button.dart';

class BookSuccessScreen extends StatefulWidget {
  const BookSuccessScreen({super.key});

  @override
  State<BookSuccessScreen> createState() => _BookSuccessScreenState();
}

class _BookSuccessScreenState extends State<BookSuccessScreen> {
  BookSuccessScreenController controller = Get.find<BookSuccessScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: contextOrange,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(
              16, 
              MediaQuery.of(context).size.height / 8, 
              16, 
              MediaQuery.of(context).size.height / 8
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/booking_success.png',
                  width: 280,
                  height: 280,
                ),
                Text(
                  'Booking Anda untuk ${controller.name} berhasil diajukan!',
                  style: h4_5(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                DefaultButton(
                  onTap: () {
                    Get.offAllNamed(
                      bookingDetailScreenRoute,
                      arguments: {
                        'id': controller.id
                      }
                    );
                  }, 
                  color: contextOrange, 
                  buttonText: 'Lihat Detail Booking'
                ),
                const SizedBox(height: 10),
                DefaultButton(
                  onTap: () {
                    Get.offAllNamed(
                      dashboardScreenRoute
                    );
                  }, 
                  color: contextGrey, 
                  buttonTextColor: Colors.white,
                  buttonText: 'Kembali ke Beranda'
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}