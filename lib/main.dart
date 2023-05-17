import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservilla/router/route_app.dart';
import 'package:reservilla/router/route_variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        fontFamily: 'Poppins'
      ),
      getPages: AppPages.pages,
      initialRoute: loginScreenRoute,
    );
  }
}
