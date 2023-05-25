import 'package:flutter/material.dart';
import 'package:reservilla/core/font_sizes.dart';

class BottomNavBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color buttonColor;
  final String buttonText;
  final double? width;

  const BottomNavBarButton({
    super.key, 
    required this.onPressed, 
    required this.buttonColor, 
    required this.buttonText, 
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          padding: MaterialStateProperty.all(const EdgeInsets.all(16))
        ),
        child: Text(
          buttonText,
          style: buttonMd(color: Colors.white),
        )
      ),
    );
  }
}