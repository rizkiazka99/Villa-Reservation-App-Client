import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';

class UploadDialog extends StatelessWidget {
  final String title;
  final int received;
  final int total;

  const UploadDialog({
    super.key, 
    required this.title, 
    required this.received, 
    required this.total
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: h5(),
      ),
      content: LinearPercentIndicator(
        addAutomaticKeepAlive: true,
        progressColor: contextOrange,
        percent: (received / total).toDouble()
      )
    );
  }
}