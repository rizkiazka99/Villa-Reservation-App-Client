import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/modules/controller/contents/bookings_screen_controller.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  BookingsScreenController controller = Get.find<BookingsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bookings'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: contextOrange,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Obx(() => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor: controller.tabBarIndex == 0 ? MaterialStateProperty.all(
                              Colors.white
                            ) : null
                          ),
                          onPressed: () {
                            controller.tabBarIndex = 0;
                          },
                          child: Text(
                            'Dipesan',
                            style: buttonMd(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor: controller.tabBarIndex == 1 ? MaterialStateProperty.all(
                              Colors.white
                            ) : null
                          ),
                          onPressed: () {
                            controller.tabBarIndex = 1;
                          },
                          child: Text(
                            'Sudah Lewat',
                            style: buttonSm(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor: controller.tabBarIndex == 2 ? MaterialStateProperty.all(
                              Colors.white
                            ) : null
                          ),
                          onPressed: () {
                            controller.tabBarIndex = 2;
                          },
                          child: Text(
                            'Batal',
                            style: buttonMd(),
                          ),
                        ),
                      )
                    ],
                  )),
                ),
                Obx(() => controller.tabBarIndex == 0 ? Booked() :
                              controller.tabBarIndex == 1 ? Text('Sudah Lewat') :
                              Text('Batal'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Booked extends StatefulWidget {
  const Booked({super.key});

  @override
  State<Booked> createState() => _BookedState();
}

class _BookedState extends State<Booked> {
  BookingsScreenController controller = Get.find<BookingsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        physics: const BouncingScrollPhysics(),
        child: Obx(() {
          if (controller.bookingsLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.7,
              child: const SpinKitRing(
                color: contextOrange,
              )
            );
          } else {
              if (controller.bookingsData != null) {
                return Column(
                children: [
                  Column(
                    children: List.generate(controller.bookingsData!.data.length, (index) => Text(
                      controller.bookingsData!.data[index].paymentVia
                    )),
                  ),
                ],
              );
              } else {
                return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: Text('Kosong')
                );
              }
          }
        }),
      )
    );
  }
}