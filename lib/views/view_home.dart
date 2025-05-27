import 'package:booking_room/controllers/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewHome extends StatelessWidget {
  
  final ControllerHome controllerHome = Get.put(ControllerHome());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text('List Bookings', style: TextStyle(
                fontSize: 20
              ),),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Obx((){
                return controllerHome.isLoading.value ?
                    Center(
                      child: SizedBox(
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    )
                    :
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controllerHome.
                        apiBookingsModel.value.data?.length,
                      itemBuilder: (context, index) {
                        bool isApprove = controllerHome.apiBookingsModel.value.
                        data![index].isApproved == 1 ? true : false;
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            height: 180,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: Colors.grey, spreadRadius: 1)
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(controllerHome.apiBookingsModel.
                                    value.data![index].roomName ?? '-',
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            controllerHome.apiBookingsModel.
                                            value.data![index].requestDate ?? '-'
                                        ),
                                        SizedBox(width: 10,),
                                        Text(controllerHome.apiBookingsModel.
                                        value.data![index].timeStart ?? '-')
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person),
                                        Text(controllerHome.apiBookingsModel.
                                        value.data![index].userName ?? '-')
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(controllerHome.apiBookingsModel.
                                        value.data![index].categoryName ?? '-',),
                                        Text(
                                          controllerHome.apiBookingsModel.value.data![index].categoryRemarks ?? '-',
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Icon( isApprove
                                   ?
                                  Icons.check : Icons.pending_actions,
                                  color: isApprove ? Colors.green : Colors.yellow,
                                  size: 40,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        onPressed: (){
                                          int? id = 0;
                                          if (controllerHome.apiBookingsModel.value.
                                          data![index].id != null) {
                                            id = controllerHome.apiBookingsModel.value.
                                            data![index].id;
                                          }
                                          Get.toNamed('/detail/$id');
                                        },
                                        child: Icon(Icons.remove_red_eye_sharp)
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
              }),
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}
