import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../helpers/DbMysql.dart';
import '../models/booking_model.dart';

class ControllerMysql extends GetxController {
  final conn = DbMysql();

  RxList bookings = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getBookings();
  }

  Future getBookings() async {
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
        // _bookings.add(BookingModel(
        //     room: row['roomname'],
        //     dateBooking: row['request_date'].toString(),
        //     hourBooking: row['time_start'].toString(),
        //     booker: row['username'],
        //     division: row['division']
        // ));
        bookings.assignAll(res);
      }
    });
    return bookings;
  }
}
