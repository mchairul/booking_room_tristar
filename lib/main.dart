import 'package:booking_room/screen1.dart';
import 'package:booking_room/screen2.dart';
import 'package:booking_room/views/view_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => ViewLogin()),
        GetPage(name: '/screen2', page: () => Screen2())
      ],
      initialRoute: '/',
      theme: ThemeData(
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.system,
    );
  }
}

