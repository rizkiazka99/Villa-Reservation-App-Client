import 'package:flutter/material.dart';

class BookSuccessScreen extends StatelessWidget {
  const BookSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/booking_success.png'
                ),
                Text(
                  'Booking'
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}