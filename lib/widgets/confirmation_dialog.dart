import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/widgets/default_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function() onConfirmation;
  
  const ConfirmationDialog({
    super.key, 
    required this.title, 
    required this.content, 
    required this.onConfirmation
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      title: Text(
        title,
        style: h5(),
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        style: bodyMd(color: contextGrey),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: DefaultButton(
                onTap: onConfirmation, 
                color: contextOrange, 
                buttonText: 'Ya'
              )
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DefaultButton(
                onTap: () {
                  Get.back();
                }, 
                color: contextRed, 
                buttonText: 'Tidak'
              )
            )
          ],
        )
      ],
    );
  }
}