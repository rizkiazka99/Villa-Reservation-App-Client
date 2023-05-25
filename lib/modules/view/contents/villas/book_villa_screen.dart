import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/helpers/date_formatter.dart';
import 'package:reservilla/modules/controller/contents/villas/book_villa_screen_controller.dart';
import 'package:reservilla/widgets/back_button.dart';
import 'package:reservilla/widgets/bottom_navbar_button.dart';
import 'package:reservilla/widgets/default_dropdown.dart';
import 'package:reservilla/widgets/default_snackbar.dart';

class BookVillaScreen extends StatefulWidget {
  const BookVillaScreen({super.key});

  @override
  State<BookVillaScreen> createState() => _BookVillaScreenState();
}

class _BookVillaScreenState extends State<BookVillaScreen> {
  BookVillaScreenController controller = Get.find<BookVillaScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        leading: backButton(),
        title: const Text(
          'Pengajuan Booking'
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Check-In',
                    style: h5(fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Obx(() => InkWell(
                    onTap: () async {
                      await controller.selectCheckInDate(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: contextOrange
                        ),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            !controller.bookingStartDateUpdated ? '--/--/--'
                                : DateFormatter.monthNameAndDaysIncluded(controller.currentDateStart, 'id_ID'),
                            style: h6()
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: contextGrey,
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text(
                    'Check-Out',
                    style: h5(fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Obx(() => InkWell(
                    onTap: () async {
                      if (controller.bookingStartDateUpdated) {
                        await controller.selectCheckOutDate(context);
                      } else {
                        defaultSnackbar('Ups!', 'Tolong pilih tanggal check-in dulu');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: contextOrange
                        ),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            !controller.bookingEndDateUpdated ? '--/--/--'
                                : DateFormatter.monthNameAndDaysIncluded(controller.currentDateEnd, 'id_ID'),
                            style: h6(),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: contextGrey,
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Metode',
                                  style: h5(fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Pembayaran',
                                  style: h5(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          Obx(() => DefaultImageDropdown(
                            width: MediaQuery.of(context).size.width / 2,
                            value: controller.selectedPaymentMethod,
                            onChanged: (value) {
                              controller.selectedPaymentMethod = value!;
                            },
                            items: controller.paymentMethods.map((method) {
                              return DropdownMenuItem(
                                value: method['name'],
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Image.asset(method['logo']),
                                ),
                              );
                            }).toList(),
                          ))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Metode pembayaran lainnya akan segera datang',
                        style: bodyMd(),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 10,
                  color: backgroundColorPrimary,
                ),
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(

                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarButton(
        onPressed: () {

        }, 
        buttonColor: contextOrange, 
        buttonText: 'Ajukan Booking'
      )
    );
  }
}