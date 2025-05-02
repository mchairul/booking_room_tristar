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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('MySQL'),
              ElevatedButton(
                  onPressed: () async {
                    controllerMysql.conn.getConnection().then((connection) {
                      String sql = 'SELECT * FROM users';
                      var res = connection.query(sql);
                      debugPrint(res.toString());
                    });
                  },
                  child: Text('Test')
              ),
              Obx((){
                return controllerMysql.bookings.length == 0 ?
                CircularProgressIndicator() :
                SizedBox(
                  height: MediaQuery.of(context).size.height,
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
                      //return Text('Ruangan ${data['roomname']}');
                      return ListTile(
                        trailing: Text('${data['roomname']}'),
                        title: Text('${data['request_date']}'),
                        subtitle: Text('${data['username']} \n'
                            '${data['division']} \n'),
                      );
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

