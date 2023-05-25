import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/router/route_app.dart';
import 'package:reservilla/router/route_variables.dart';

void main() async {
  await initializeDateFormatting('id_ID', null).then((value) =>
    runApp(const MyApp())
  );  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReserVilla',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        colorSchemeSeed: contextOrange,
        fontFamily: 'Poppins'
      ),
      getPages: AppPages.pages,
      initialRoute: splashScreenRoute,
    );
  }
}
