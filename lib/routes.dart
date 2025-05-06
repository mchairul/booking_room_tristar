import 'package:booking_room/main.dart';
import 'package:booking_room/views/view_home.dart';
import 'package:booking_room/views/view_login.dart';
import 'package:booking_room/views/view_mysql.dart';
import 'package:booking_room/views/view_mysql_add.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/mysql', page: () => ViewMysql()),
  GetPage(name: '/mysql-add', page: () => ViewMysqlAdd()),
  //
  GetPage(name: '/', page: () => MyApp()),
  GetPage(name: '/home', page: () => ViewHome()),
  GetPage(name: '/login', page: () => ViewLogin())
];
