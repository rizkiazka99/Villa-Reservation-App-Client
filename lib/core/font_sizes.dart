import 'package:flutter/material.dart';
import 'package:reservilla/core/colors.dart';

const textPrimaryBold =
    TextStyle(color: primaryColor, fontWeight: FontWeight.bold);
dynamic textWarningBold =
    TextStyle(color: warningColor, fontWeight: FontWeight.bold);
dynamic textSuccessBold =
    TextStyle(color: successColor, fontWeight: FontWeight.bold);
const textPrimaryReguler =
    TextStyle(color: primaryColor, fontWeight: FontWeight.normal);
const textPrimaryLight =
    TextStyle(color: primaryColor, fontWeight: FontWeight.w300);
const textBlackBold =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
const textDangerReguler = TextStyle(color: Colors.red);
const textBlackReguler = TextStyle(color: Colors.black);
const textWhite = TextStyle(color: Colors.white);
const textGray = TextStyle(color: Colors.grey);

//headline
h1({color = textBlack, fontFamily}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 40, fontFamily: fontFamily);
}

h2({color = textBlack, fontFamily}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 28, fontFamily: fontFamily);
}

h3({color = textBlack, fontFamily}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 24, fontFamily: fontFamily);
}

h4({color = textBlack, fontFamily}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20, fontFamily: fontFamily);
}

h4_5({color = textBlack, fontFamily}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18, fontFamily: fontFamily);
}

h5({color = textBlack, fontWeight = FontWeight.bold, fontStyle = FontStyle.normal, fontFamily}) {
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: 16, fontStyle: fontStyle, fontFamily: fontFamily);
}

h6({color = textBlack, fontWeight = FontWeight.bold, fontFamily}) {
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: 14, fontFamily: fontFamily);
}

h7({color = textBlack, fontWeight = FontWeight.bold, fontFamily}) {
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: 12, fontFamily: fontFamily);
}

//body
bodyLg({color = textBlack, fontWeight = FontWeight.bold, fontFamily}) {
  return TextStyle(color: color, fontSize: 16, letterSpacing: 2, fontWeight: fontWeight, fontFamily: fontFamily);
}

bodyMd({color = textGrey, fontWeight = FontWeight.normal, fontStyle = FontStyle.normal, fontFamily}) {
  return TextStyle(color: color, fontSize: 14, fontWeight: fontWeight, fontStyle: fontStyle, fontFamily: fontFamily);
}

bodySm({color = textBlack, fontWeight = FontWeight.normal, fontFamily}) {
  return TextStyle(color: color, fontSize: 12, fontWeight: fontWeight, fontFamily: fontFamily);
}

bodyXs({color = textBlack, fontFamily}) {
  return TextStyle(color: color, fontSize: 10, fontFamily: fontFamily);
}

bodyXsGrey({color = textGrey, fontSize, fontFamily}) {
  return TextStyle(color: color, fontSize: fontSize, fontFamily: fontFamily);
}

//button
buttonLg({color = textBlack, fontFamily}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: fontFamily);
}

buttonMd({color = textBlack, fontWeight = FontWeight.bold, fontFamily}) {
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: 14, fontFamily: fontFamily);
}

buttonSm({color = textBlack, fontFamily}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: fontFamily);
}

//text button
txtButtonMd({color = textOrange, fontFamily}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: fontFamily);
}

txtButtonSm({color = textOrange, fontFamily}) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: fontFamily);
}