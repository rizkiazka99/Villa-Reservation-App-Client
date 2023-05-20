import 'package:flutter/material.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bookings'),
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
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: backgroundColorPrimary,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}