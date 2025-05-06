import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/DbMysql.dart';
import '../models/booking_model.dart';

class ControllerMysql extends GetxController {
  final conn = DbMysql();

  RxList<BookingModel> bookings = <BookingModel>[].obs;
  RxBool loading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBookings();
  }
  
  String getTime(String stringTime) {
    var time = stringTime.substring(0,5);
    return time;
  }
  Future getBookings() async {
    await Timer(Duration(seconds: 2),() async {
      debugPrint('delay 2 detik');
      conn.getConnection().then((connection) async {
        String sql = 'SELECT'
            ' bookings.* , users.nik, users.name as username, users.division ,rooms.name as roomname,'
            'categories.name as name_category, categories.remarks as ket_category '
            'FROM bookings '
            'JOIN users ON bookings.users_id = users.id '
            'JOIN rooms ON bookings.rooms_id = rooms.id '
            'JOIN categories ON bookings.categories_id = categories.id';
        final res = await connection.query(sql);
        for (var row in res) {
          debugPrint('Room: ${row['roomname']}');
          String dateBook = DateFormat('dd-mm-yyy').format(row['request_date']);
          String hourBook = getTime(row['time_start'].toString());
          bookings.add(BookingModel(
              room: row['roomname'],
              dateBooking: dateBook,
              hourBooking: hourBook,
              booker: row['username'],
              division: row['division']
          ));
          //bookings.assignAll(res);
          loading.value = false;
        }
      });
    });
  }
}
