
import 'dart:io';

import 'package:booking_room/models/api_bookings_model.dart';
import 'package:booking_room/services/booking_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ControllerHome extends GetxController {
  late final BookingService _bookingService;

  Rx<ApiBookingsModel> apiBookingsModel = ApiBookingsModel().obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _bookingService = Get.put(BookingService());
    getBookings();
  }

  getBookings() async {
    isLoading.value = true;

    final response = await _bookingService.listBookings();
    // jika response http code 200
    if (response.statusCode == HttpStatus.ok) {
      apiBookingsModel.value = ApiBookingsModel.fromJson(response.body);
    } else {
      // jika response http code 401
      if (response.statusCode == HttpStatus.unauthorized) {
        Get.offNamed('/login');
      } else {
        // error lain nya
        Get.snackbar(
            "Gagal mendapatkan list booking",
            "Unknown error",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.yellow
        );
      }
    }

    isLoading.value = false;
  }
}