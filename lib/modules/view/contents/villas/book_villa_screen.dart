import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/modules/controller/contents/villas/book_villa_screen_controller.dart';
import 'package:reservilla/widgets/back_button.dart';

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
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Book Villa')
              ],
            ),
          ),
        ),
      ),
    );
  }
}