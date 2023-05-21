import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                  controller.tabBarIndex == 1 ? PastBookings() :
                  CancelledBookings()
                )
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
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
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
              if (controller.booked.isNotEmpty) {
                return Column(
                children: [
                  Column(
                    children: List.generate(controller.booked.length, (index) => Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: contextGrey.withOpacity(0.1),
                            blurRadius: 7,
                            spreadRadius: 5,
                            offset: const Offset(0, 3)
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.booked[index].villa.name,
                                      style: h4(),
                                    ),
                                    Text(
                                      'Booking ID: ${controller.booked[index].id}',
                                      style: bodyMd(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Obx(() => Image.asset(
                                  controller.booked[index].paymentVia == 'permata' ? 'assets/images/bank_permata.png' :
                                    'assets/images/bca.png',
                                    width: 100,
                                    height: 50,
                                )),
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                            color: contextOrange,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Check-In',
                                      style: bodyMd(),
                                    ),
                                    Text(
                                      controller.booked[index].bookingStartDate,
                                      style: bodyMd(
                                        fontWeight: FontWeight.bold,
                                        color: contextOrange
                                      )
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                width: 1,
                                child: Container(
                                  color: contextOrange,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Check-Out',
                                      style: bodyMd(),
                                    ),
                                    Text(
                                      controller.booked[index].bookingEndDate,
                                      style: bodyMd(
                                        fontWeight: FontWeight.bold,
                                        color: contextOrange
                                      )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Status:',
                                style: bodyMd(),
                              ),
                              Obx(() => Text(
                                controller.booked[index].status == 'settlement' ? ' TELAH DIBAYAR' : ' MENUNGGU PEMBAYARAN',
                                style: bodyMd(
                                  fontWeight: FontWeight.bold,
                                  color: contextOrange
                                )
                              ))
                            ],
                          ),
                        ],
                      ),
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

class PastBookings extends StatefulWidget {
  const PastBookings({super.key});

  @override
  State<PastBookings> createState() => _PastBookingsState();
}

class _PastBookingsState extends State<PastBookings> {
  BookingsScreenController controller = Get.find<BookingsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
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
              if (controller.pastBooking.isNotEmpty) {
                return Column(
                children: [
                  Column(
                    children: List.generate(controller.pastBooking.length, (index) => Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: contextGrey.withOpacity(0.1),
                            blurRadius: 7,
                            spreadRadius: 5,
                            offset: const Offset(0, 3)
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.pastBooking[index].villa.name,
                                      style: h4(),
                                    ),
                                    Text(
                                      'Booking ID: ${controller.pastBooking[index].id}',
                                      style: bodyMd(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Obx(() => Image.asset(
                                  controller.pastBooking[index].paymentVia == 'permata' ? 'assets/images/bank_permata.png' :
                                    'assets/images/bca.png',
                                    width: 100,
                                    height: 50,
                                )),
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                            color: contextOrange,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Check-In',
                                      style: bodyMd(),
                                    ),
                                    Text(
                                      controller.pastBooking[index].bookingStartDate,
                                      style: bodyMd(
                                        fontWeight: FontWeight.bold,
                                        color: contextOrange
                                      )
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                width: 1,
                                child: Container(
                                  color: contextOrange,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Check-Out',
                                      style: bodyMd(),
                                    ),
                                    Text(
                                      controller.pastBooking[index].bookingEndDate,
                                      style: bodyMd(
                                        fontWeight: FontWeight.bold,
                                        color: contextOrange
                                      )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Status:',
                                style: bodyMd(),
                              ),
                              Obx(() => Text(
                                controller.pastBooking[index].status == 'settlement' ? ' TELAH DIBAYAR' : ' MENUNGGU PEMBAYARAN',
                                style: bodyMd(
                                  fontWeight: FontWeight.bold,
                                  color: contextOrange
                                )
                              ))
                            ],
                          ),
                        ],
                      ),
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

class CancelledBookings extends StatefulWidget {
  const CancelledBookings({super.key});

  @override
  State<CancelledBookings> createState() => _CancelledBookingsState();
}

class _CancelledBookingsState extends State<CancelledBookings> {
  BookingsScreenController controller = Get.find<BookingsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
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
              if (controller.cancelledBooking.isNotEmpty) {
                return Column(
                children: [
                  Column(
                    children: List.generate(controller.cancelledBooking.length, (index) => Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: contextGrey.withOpacity(0.1),
                            blurRadius: 7,
                            spreadRadius: 5,
                            offset: const Offset(0, 3)
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.cancelledBooking[index].villa.name,
                                      style: h4(),
                                    ),
                                    Text(
                                      'Booking ID: ${controller.cancelledBooking[index].id}',
                                      style: bodyMd(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Obx(() => Image.asset(
                                  controller.cancelledBooking[index].paymentVia == 'permata' ? 'assets/images/bank_permata.png' :
                                    'assets/images/bca.png',
                                    width: 100,
                                    height: 50,
                                )),
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                            color: contextOrange,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Check-In',
                                      style: bodyMd(),
                                    ),
                                    Text(
                                      controller.cancelledBooking[index].bookingStartDate,
                                      style: bodyMd(
                                        fontWeight: FontWeight.bold,
                                        color: contextOrange
                                      )
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                width: 1,
                                child: Container(
                                  color: contextOrange,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Check-Out',
                                      style: bodyMd(),
                                    ),
                                    Text(
                                      controller.cancelledBooking[index].bookingEndDate,
                                      style: bodyMd(
                                        fontWeight: FontWeight.bold,
                                        color: contextOrange
                                      )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Status:',
                                style: bodyMd(),
                              ),
                              Text(
                                ' BATAL',
                                style: bodyMd(
                                  fontWeight: FontWeight.bold,
                                  color: contextOrange
                                )
                              )
                            ],
                          ),
                        ],
                      ),
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