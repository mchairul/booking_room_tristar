import 'package:booking_room/controllers/controller_detail_booking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewDetailBooking extends StatelessWidget {

  final ControllerDetailBooking controllerDetailBooking = Get.put(ControllerDetailBooking());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Obx((){
          return Padding(padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ruangan', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.roomName.value)
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kategor', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.categoryName.value)
                  ],
                ),

            ],
          ),);
        }),
      )),
    );
  }
}
