import 'package:booking_room/main.dart';
import 'package:booking_room/views/view_home.dart';
import 'package:booking_room/views/view_login.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/', page: () => MyApp()),
  GetPage(name: '/home', page: () => ViewHome()),
  GetPage(name: '/login', page: () => ViewLogin())
];
