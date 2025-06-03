import 'package:booking_room/controllers/controller_detail_booking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewDetailBooking extends StatelessWidget {

  final ControllerDetailBooking controllerDetailBooking = Get.put(ControllerDetailBooking());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Obx((){
          return Padding(padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('NIK', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['nik'] ?? '')
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nama', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['user_name'] ?? '')
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ruangan', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['room_name'] ?? '')
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['category_name']  ?? '')
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kat Kategori', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['category_remarks']  ?? '')
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ket Kategori', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['category_remarks']  ?? '')
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tgl Diminta', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['request_date']  ?? '')
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tgl Dibutuhkan', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['required_date']  ?? '')
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Jam Dibutuhkan', style: TextStyle(fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                        Text(controllerDetailBooking.detailBooking['time_start']  ?? ''),
                        Text(' s/d '),
                        Text(controllerDetailBooking.detailBooking['time_end']  ?? '')
                      ],
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Daftar Peserta', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['participants'].toString()  ?? '')
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Sarana Yang Dibutuhkan', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['facilities'].toString()  ?? '')
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Sarana Lain', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['facilities_other'].toString()  ?? '')
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Keterangan', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['description'].toString()  ?? '')
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Approval By HRD Ga', style: TextStyle(fontWeight: FontWeight.bold),),
                    controllerDetailBooking.detailBooking['is_approved'] == 1 ?
                        Icon(Icons.check, color: Colors.green,) :
                    Icon(Icons.pending_actions, color: Colors.yellow,)
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tgl. Approval', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(controllerDetailBooking.detailBooking['updated_at']  ?? '')
                  ],
                ),

            ],
          ),);
        }),
      )),
    );
  }
}
