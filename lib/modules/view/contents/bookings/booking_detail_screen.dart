import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/modules/controller/contents/bookings/booking_detail_controller.dart';
import 'package:reservilla/widgets/default_snackbar.dart';
import 'package:reservilla/widgets/loading_state.dart';
import 'package:reservilla/widgets/custom_icon_button.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({super.key});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  BookingDetailController controller = Get.find<BookingDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomIconButton(
          onTap: () {
            Get.back();
          },
          padding: 8,
          radius: 12,
          borderColor: backgroundColorPrimary,
          icon: Icons.arrow_back_ios_rounded,
          iconColor: contextOrange,
          iconSize: 16,
        ),
        title: Obx(() => controller.bookingDetailLoading ? const Text('Booking') : 
          Text(
            'Booking ${controller.bookingDetailData!.data.id}'
          )
        ),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Obx(() {
            if (controller.bookingDetailLoading) {
              return LoadingState(
                height: MediaQuery.of(context).size.height / 2,
              );
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      child: Obx(() => controller.bookingDetailData!.data.villa.villaGaleries.isNotEmpty ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: 'http://10.0.2.2:3000/${controller.bookingDetailData!.data.villa.villaGaleries[0].imageName}',
                        fadeInDuration: const Duration(milliseconds: 300),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        placeholder: (context, url) => const SpinKitThreeBounce(
                          color: contextOrange,
                          size: 18
                        ),
                      ) : Image.asset(
                        'assets/images/placeholder.webp'
                      )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.bookingDetailData!.data.villa.name,
                                  style: h3(color: contextOrange),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: contextRed,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      controller.bookingDetailData!.data.villa.location.name,
                                      style: bodyMd(color: contextGrey),
                                    )
                                  ],
                                ) 
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomIconButton(
                                  onTap: () {
                                    String phoneNumber = controller.bookingDetailData!.data.villa.phone;
                                    controller.launchDialer(phoneNumber);
                                  },
                                  radius: 100,
                                  icon: Icons.phone,
                                ),
                                const SizedBox(width: 8),
                                CustomIconButton(
                                  onTap: () {
                                    String mapsUrl = controller.bookingDetailData!.data.villa.mapUrl;
                                    controller.launchMaps(mapsUrl);
                                  },
                                  radius: 100,
                                  icon: Icons.location_on
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 8,
                      color: backgroundColorPrimary,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Waktu Inap',
                            style: h4(color: contextOrange),
                          ),
                          Row(
                            children: [
                              Text(
                                'Check-In',
                                style: bodyMd(color: contextGrey),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  ': ',
                                  style: bodyMd(color: contextGrey),
                                ),
                              ),
                              Text(
                                controller.bookingDetailData!.data.bookingStartDate,
                                style: bodyMd(
                                  color: contextOrange,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Check-Out',
                                style: bodyMd(color: contextGrey),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text(
                                  ': ',
                                  style: bodyMd(color: contextGrey),
                                ),
                              ),
                              Text(
                                controller.bookingDetailData!.data.bookingEndDate,
                                style: bodyMd(
                                  color: contextOrange,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 8,
                      color: backgroundColorPrimary,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pembayaran',
                            style: h4(color: contextOrange),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Obx(() => Image.asset(
                                  controller.bookingDetailData!.data.paymentVia == 'permata' ?
                                      'assets/images/bank_permata.png' : 'assets/images/bca.png',
                                  width: 100,
                                  height: 100
                                )),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Status',
                                      style: bodyMd(color: contextGrey),
                                    ),
                                    Obx(() => Text(
                                      controller.bookingDetailData!.data.status == 'settlement' ?
                                          'TELAH DIBAYAR' : controller.bookingDetailData!.data.status == 'pending' ?
                                           'MENUNGGU PEMBAYARAN' : 'BATAL',
                                      style: h5(color: contextOrange),
                                    )),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Total',
                                      style: bodyMd(color: contextGrey),
                                    ),
                                    Text(
                                      'Rp. ${controller.bookingDetailData!.data.payment.grossAmount}',
                                      style: h5(color: contextOrange),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Nomor VA',
                                          style: bodyMd(color: contextGrey),
                                        ),
                                        const SizedBox(width: 5),
                                        InkWell(
                                          onTap: () {
                                            if (controller.bookingDetailData!.data.payment.permataVaNumber != null) {
                                              Clipboard.setData(ClipboardData(text: controller.bookingDetailData!.data.payment.permataVaNumber!));
                                            } else {
                                              Clipboard.setData(ClipboardData(text: controller.bookingDetailData!.data.payment.vaNumbers![0].vaNumber));
                                            }

                                            defaultSnackbar('Sukses!', 'Nomor Virtual Account telah tersalin ke clipboard');
                                          },
                                          child: const Icon(
                                            Icons.copy,
                                            color: contextOrange,
                                            size: 18
                                          ),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onLongPress: () {
                                        if (controller.bookingDetailData!.data.payment.permataVaNumber != null) {
                                          Clipboard.setData(ClipboardData(text: controller.bookingDetailData!.data.payment.permataVaNumber!));
                                        } else {
                                          Clipboard.setData(ClipboardData(text: controller.bookingDetailData!.data.payment.vaNumbers![0].vaNumber));
                                        }

                                        defaultSnackbar('Sukses!', 'Nomor Virtual Account telah tersalin ke clipboard');
                                      },
                                      child: Obx(() => Text(
                                        controller.bookingDetailData!.data.payment.permataVaNumber != null ?
                                            controller.bookingDetailData!.data.payment.permataVaNumber! :
                                            controller.bookingDetailData!.data.payment.vaNumbers![0].vaNumber,
                                        style: h5(color: contextOrange),
                                      )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          }),
        )
      ),
    );
  }
}