
import 'dart:io';

import 'package:booking_room/helpers/state_data.dart';
import 'package:booking_room/models/api_bookings_model.dart';
import 'package:booking_room/services/booking_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerHome extends GetxController {
  late final BookingService _bookingService;
  late final StateData _stateData;

  Rx<ApiBookingsModel> apiBookingsModel = ApiBookingsModel().obs;

  RxBool isLoading = false.obs;
  RxInt level = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _bookingService = Get.put(BookingService());
    _stateData = Get.put(StateData());
    getBookings();
    setLevel();
  }

  Future<void> getBookings() async {
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

  setLevel() {
    level.value = _stateData.level.value;
  }

  approveBooking(int id) async {
    isLoading.value = true;
    final response = await _bookingService.approveBooking(id);
    print(response.body.toString());
    if(response.statusCode == HttpStatus.ok) {
      Get.defaultDialog(
        title: 'Berhasil',
        middleText: 'Booking Berhasil Diapprove',
        onConfirm: (){
          Get.back();
        }
      );
    } else {
      Get.snackbar(
          "Gagal",
          "Approve Gagal ${response.body.message}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red
      );
    }
    isLoading.value = false;
    getBookings();
  }

  logout() async {
    final response = await _bookingService.logout();
    if(response.statusCode == HttpStatus.ok) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      _stateData.authToken.value = '';
      _stateData.level.value = 0;
      Get.offNamed('/login');
    } else {
      Get.snackbar(
          "Gagal",
          "Logout Gagal ${response.body['message']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red
      );
    }
  }
}
