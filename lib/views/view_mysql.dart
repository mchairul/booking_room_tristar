import 'package:booking_room/controllers/controller_mysql.dart';
import 'package:booking_room/helpers/DbMysql.dart';
import 'package:booking_room/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysql1/mysql1.dart';

class ViewMysql extends StatelessWidget {
  final ControllerMysql controllerMysql = Get.put(ControllerMysql());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('MySQL'),
                ElevatedButton(
                    onPressed: () {
                      Get.offNamed('mysql-add');
                    },
                    child: Text('Booking')
                ),
                Obx((){
                  return controllerMysql.loading.value == false ?
                  controllerMysql.bookings.length == 0 ?
                  Text('No Data') :
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1,
                          thickness: 2,
                        );
                      },
                      itemCount: controllerMysql.bookings.length,
                      itemBuilder: (context, index) {
                        var data = controllerMysql.bookings[index];

                        return ListTile(
                          trailing: Text('${data.room}'),
                          title: Text('${data.dateBooking}'),
                          subtitle: Text('${data.booker} \n'
                              '${data.division} \n'),
                        );
                      },
                    ),
                  ) :
                  CircularProgressIndicator();
                }),
                Obx((){
                  return controllerMysql.loading.value == false ?
                  controllerMysql.bookings.length == 0 ?
                  Text('No Data') :
                  Container(
                    height: 300,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: [
                              DataColumn(label: Text('Ruangan')),
                              DataColumn(label: Text('Tgl booking')),
                              DataColumn(label: Text('Jam')),
                              DataColumn(label: Text('Pemesan')),
                              DataColumn(label: Text('Bagian')),
                            ],
                            rows: List<DataRow>.generate(controllerMysql.bookings.length,(index){
                              return DataRow(
                                  cells: [
                                    DataCell(
                                      Text('${controllerMysql.bookings[index].room}'),
                                    ),
                                    DataCell(
                                      Text('${controllerMysql.bookings[index].dateBooking}'),
                                    ),
                                    DataCell(
                                      Text('${controllerMysql.bookings[index].hourBooking}'),
                                    ),
                                    DataCell(
                                      Text('${controllerMysql.bookings[index].booker}'),
                                    ),
                                    DataCell(
                                      Text('${controllerMysql.bookings[index].division}'),
                                    ),
                                  ]
                              );
                            })
                        ),
                      ),
                    ),
                  ) :
                  CircularProgressIndicator();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

