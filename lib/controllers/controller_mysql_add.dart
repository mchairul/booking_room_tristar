import 'package:booking_room/helpers/DbMysql.dart';
import 'package:booking_room/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ControllerMysqlAdd extends GetxController{
  final conn = DbMysql();

  RxList<CategoriesModel> categories = <CategoriesModel>[
    CategoriesModel(
      id: 0,
      name: 'Pilih Ruangan'
    )
  ].obs;

  var formKey = GlobalKey<FormState>();
  var dateBooking = DateTime.now().obs;
  var requiredDateBooking = DateTime.now().obs;

  var startTime = ''.obs;
  var endTime = ''.obs;
  var selectedRoom = 0.obs;

  TextEditingController requestDateCtrl = TextEditingController();
  TextEditingController requiredDateCtrl = TextEditingController();
  TextEditingController timeStartCtrl = TextEditingController();
  TextEditingController timeEndCtrl = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRooms();
  }

  void selectDateRequestBook() async {
    final DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030,12,31)
    );
    if (pickedDate != null) {
      dateBooking.value = pickedDate;
      requestDateCtrl.text = DateFormat('yyyy-MM-dd').format(dateBooking.value)
          .toString();
    }
  }

  void selectDateRequiredBook() async {
    final DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030,12,31)
    );
    if (pickedDate != null) {
      requiredDateBooking.value = pickedDate;
      requiredDateCtrl.text = DateFormat('yyyy-MM-dd')
          .format(requiredDateBooking.value)
          .toString();
    }
  }

  Future getRooms() async {
    debugPrint('Starting getRooms()');
    conn.getConnection().then((connection) async{
      String sql = 'SELECT id, name FROM rooms';
      final res = await connection.query(sql);
      for (var row in res) {
        categories.add(
          CategoriesModel(
            id: row['id'],
            name: row['name']
          )
        );
      }
    });
  }

  void selectTimeStartBook() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now()
    );
    if (pickedTime != null) {
      startTime.value = pickedTime.format(Get.context!);
      timeStartCtrl.text = pickedTime.format(Get.context!);
    }
  }
}