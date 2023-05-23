import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/modules/controller/contents/bookings/bookings_screen_controller.dart';
import 'package:reservilla/widgets/booking_card.dart';
import 'package:reservilla/widgets/default_dropdown.dart';
import 'package:reservilla/widgets/empty_state.dart';
import 'package:reservilla/widgets/loading_state.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  BookingsScreenController controller = Get.find<BookingsScreenController>();

  Widget customTabBar() {
    return Container(
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
                backgroundColor: controller.tabBarIndex == 0
                  ? MaterialStateProperty.all(Colors.white)
                  : null
              ),
              onPressed: () {
                controller.tabBarIndex = 0;
                controller.scrollController.jumpTo(0);
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
              backgroundColor: controller.tabBarIndex == 1
                ? MaterialStateProperty.all(Colors.white)
                : null
              ),
              onPressed: () {
                controller.tabBarIndex = 1;
                controller.scrollController.jumpTo(0);
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
                backgroundColor: controller.tabBarIndex == 2
                  ? MaterialStateProperty.all(Colors.white)
                  : null
                ),
                onPressed: () {
                  controller.tabBarIndex = 2;
                  controller.scrollController.jumpTo(0);
                },
                child: Text(
                  'Batal',
                  style: buttonMd(),
                ),
            ),
          )
        ],
      )),
    );
  }

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
                customTabBar(),
                Obx(() => controller.tabBarIndex == 0 ? DefaultDropdown(
                  value: controller.selectedStatus,
                  margin: const EdgeInsets.only(top: 15),
                  onChanged: (value) {
                    controller.selectedStatus = value!;
                    if (controller.selectedStatus == 'Semua') {
                      controller.filteredBooked = controller.booked;
                    } else if (controller.selectedStatus == 'Menunggu Pembayaran') {
                        controller.filteredBooked = controller.booked.where((booking) {
                          return booking.status == 'pending'; 
                        }).toList();
                    } else if (controller.selectedStatus == 'Telah Dibayar') {
                        controller.filteredBooked = controller.booked.where((booking) {
                          return booking.status == 'settlement';
                        }).toList();
                    }
                    controller.scrollController.jumpTo(0);
                  }, 
                  items: controller.bookingStatus.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList()
                ) : const SizedBox.shrink()),
                Expanded(
                  child: Obx(() => controller.tabBarIndex == 0 ? const Booked() :
                    controller.tabBarIndex == 1 ? const PastBookings() :
                    const CancelledBookings()
                  ),
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
    return RefreshIndicator(
      onRefresh: () {
        return controller.getBookingsByUser();
      },
      child: SingleChildScrollView(
        controller: controller.scrollController,
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        physics: const BouncingScrollPhysics(),
        child: Obx(() {
          if (controller.bookingsLoading) {
            return LoadingState(
              height: MediaQuery.of(context).size.height / 1.7,
            );
          } else {
            if (!controller.isFetched && controller.booked.isEmpty) {
              return const SizedBox.shrink();
            } else if (controller.isFetched && controller.booked.isEmpty || controller.filteredBooked.isEmpty) {
              return EmptyState(
                height: MediaQuery.of(context).size.height / 2, 
                imageAsset: 'assets/images/empty.png', 
                message: 'Anda belum memiliki booking aktif'
              );
            } else {
              return BookingCard(
                bookingList: controller.filteredBooked
              );
            }
          }
        }),
      ),
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
    return RefreshIndicator(
      onRefresh: () {
        return controller.getBookingsByUser();
      },
      child: SingleChildScrollView(
        controller: controller.scrollController,
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        physics: const BouncingScrollPhysics(),
        child: Obx(() {
          if (controller.bookingsLoading) {
            return LoadingState(
              height: MediaQuery.of(context).size.height / 1.7,
            );
          } else {
            if (!controller.isFetched && controller.pastBooking.isEmpty) {
              return const SizedBox.shrink();
            } else if (controller.isFetched && controller.pastBooking.isEmpty) {
              return EmptyState(
                height: MediaQuery.of(context).size.height / 1.7, 
                imageAsset: 'assets/images/empty.png', 
                message: 'Anda belum memiliki booking yang telah berlalu'
              );
            } else {
              return BookingCard(
                bookingList: controller.pastBooking
              );
            }
          }
        }),
      ),
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
    return RefreshIndicator(
      onRefresh: () {
        return controller.getBookingsByUser();
      },
      child: SingleChildScrollView(
        controller: controller.scrollController,
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        physics: const BouncingScrollPhysics(),
        child: Obx(() {
          if (controller.bookingsLoading) {
            return LoadingState(
              height: MediaQuery.of(context).size.height / 1.7,
            );
          } else {
            if (!controller.isFetched && controller.cancelledBooking.isEmpty) {
              return const SizedBox.shrink();
            } else if (controller.isFetched && controller.cancelledBooking.isEmpty) { 
              return EmptyState(
                height: MediaQuery.of(context).size.height / 1.7, 
                imageAsset: 'assets/images/empty.png', 
                message: 'Anda belum memiliki booking yang dibatalkan'
              );
            } else {
              return BookingCard(
                bookingList: controller.cancelledBooking
              );
            }
          }
        }),
      ),
    );
  }
}