import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/data/models/contents/bookings/bookings_response.dart';
import 'package:reservilla/data/models/miscellaneous/user_response.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:reservilla/helpers/date_formatter.dart';
import 'package:reservilla/modules/controller/contents/bookings/bookings_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';

class BookingCard extends StatefulWidget {
  final List<Datum> bookingList;
  final UserResponse? user;

  const BookingCard({
    super.key, 
    required this.bookingList,
    required this.user,
  });

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  BookingsScreenController controller = Get.put(BookingsScreenController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.bookingList.length,
        (index) => Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
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
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(
                    bookingDetailScreenRoute, 
                    arguments: {
                      'id': widget.bookingList[index].id
                    }
                  );
                },
                child: Column(
                  children: [
                    Obx(() => widget.bookingList[index].villa.villaGaleries.isNotEmpty ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: baseUrlImg + widget.bookingList[index].villa.villaGaleries[0].imageName,
                      fadeInDuration: const Duration(milliseconds: 300),
                      errorWidget: (context, url, error) => Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)
                          ),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.error)
                      ),
                      placeholder: (context, url) => Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)
                          ),
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
                        child: const SpinKitThreeBounce(
                          color: contextOrange,
                          size: 18
                        ),
                      ),
                    ) : Image.asset(
                      'assets/images/placeholder.webp'
                    )),
                    Obx(() => Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: controller.needReview == false ? 
                              const Radius.circular(15) : const Radius.circular(0),
                          bottomRight: controller.needReview == false ? 
                              const Radius.circular(15) : const Radius.circular(0)
                        ),
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
                                      widget.bookingList[index].villa.name,
                                      style: h4(),
                                    ),
                                    Text(
                                      'Booking ID: ${widget.bookingList[index].id}',
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
                                  widget.bookingList[index].paymentVia == 'permata'
                                      ? 'assets/images/bank_permata.png'
                                      : 'assets/images/bca.png',
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
                                      DateFormatter.monthNameIncluded(
                                        DateFormat('dd-MM-yyyy').parse(widget.bookingList[index].bookingStartDate), 
                                        'id_ID'
                                      ),
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
                                      DateFormatter.monthNameIncluded(
                                        DateFormat('dd-MM-yyyy').parse(widget.bookingList[index].bookingEndDate), 
                                        'id_ID'
                                      ),
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
                                widget.bookingList[index].status == 'settlement' ? ' TELAH DIBAYAR' :
                                    widget.bookingList[index].status == 'pending' ? ' MENUNGGU PEMBAYARAN' :
                                    ' BATAL',
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
                  ],
                ),
              ),
              Obx(() {
                DateTime formattedBookingEndDate = DateFormat('dd-MM-yyyy')
                    .parse(widget.bookingList[index].bookingEndDate);

                if (formattedBookingEndDate.isBefore(DateTime.now())) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(
                        addReviewScreenRoute,
                        arguments: {
                          'VillaId': widget.bookingList[index].villaId,
                          'villa_name': widget.bookingList[index].villa.name
                        }
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: contextOrange,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)
                        )
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.message,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Berikan Ulasan Anda',
                            style: h5(color: Colors.white)
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })
            ],
          ),
        )
      ),
    );
  }
}