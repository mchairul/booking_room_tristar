import 'package:booking_room/helpers/state_data.dart';
import 'package:booking_room/models/room_model.dart';
import 'package:booking_room/services/booking_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ControllerAddBooking extends GetxController {
  late StateData _stateData;
  late BookingService _bookingService;

  RxMap facilities = {}.obs;

  RxList<RoomModel> rooms = <RoomModel>[
    RoomModel(
      id: 0,
      name: 'Pilih Ruangan'
    )
  ].obs;

  TextEditingController dateRequestCtrl = TextEditingController();
  TextEditingController roomCtrl = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _stateData = Get.put(StateData());
    _bookingService = Get.put(BookingService());
    getFacilities();
    getRooms();
  }

  getFacilities() async {
    final response = await _bookingService.facilities();

    for (var row in response.body['data']) {
      facilities.addAll(row);
    }
  }

  getRooms() async {
    final response = await _bookingService.rooms();

    for (var row in response.body['data']) {
      rooms.add(
        RoomModel(
          id: row['id'],
          name: row['name']
        )
      );
    }
  }
}
