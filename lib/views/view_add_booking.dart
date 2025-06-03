import 'package:booking_room/controllers/controller_add_booking.dart';
import 'package:booking_room/utils/widgets/new_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAddBooking extends StatelessWidget {
  final ControllerAddBooking controllerAddBooking = Get.put(ControllerAddBooking());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.offNamed('/home');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Obx(() {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Tgl Diminta'),
                  TextFormField(
                    controller: controllerAddBooking.dateRequestCtrl,
                    decoration: newInputDecoration('Tgl Diminta'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email Tidak Boleh Kosong";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  Text('Ruangan'),
                  DropdownButtonFormField(
                      items: List<DropdownMenuItem>.generate(
                        controllerAddBooking.rooms.length, (index) {
                          return DropdownMenuItem(
                            value: controllerAddBooking.rooms[index].id,
                            child: Text(
                              controllerAddBooking.rooms[index].name!
                            ),
                          );
                        }
                      ),
                      onChanged: (newValue){
                      }
                  )
                ],
              ),
            ),
          );
        }),
      )),
    );
  }
}
