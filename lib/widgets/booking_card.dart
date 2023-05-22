import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/data/models/contents/bookings/bookings_response.dart';
import 'package:reservilla/modules/controller/contents/bookings/booking_detail_controller.dart';
import 'package:reservilla/router/route_variables.dart';

class BookingCard extends StatefulWidget {
  final List<Datum> bookingList;
  const BookingCard({
    super.key, 
    required this.bookingList
  });

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.bookingList.length,
        (index) => InkWell(
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
                imageUrl: 'http://10.0.2.2:3000/${widget.bookingList[index].villa.villaGaleries[0].imageName}',
                fadeInDuration: const Duration(milliseconds: 300),
                errorWidget: (context, url, error) => Container(
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
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)
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
                                widget.bookingList[index].bookingStartDate,
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
                                widget.bookingList[index].bookingEndDate,
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
              ),
            ],
          ),
        )
      ),
    );
  }
}