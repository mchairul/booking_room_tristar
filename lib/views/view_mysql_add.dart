import 'package:booking_room/controllers/controller_mysql_add.dart';
import 'package:booking_room/utils/widgets/my_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewMysqlAdd extends StatelessWidget {
  final ControllerMysqlAdd controllerMysqlAdd = Get.put(ControllerMysqlAdd());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 50,),
                Form(key: controllerMysqlAdd.formKey,child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text('Tgl. Diminta'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            controller: controllerMysqlAdd.requestDateCtrl,
                            decoration: bookingDecoration(
                              IconButton(onPressed: (){
                                controllerMysqlAdd.selectDateRequestBook();
                                },
                                  icon: Icon(Icons.date_range)
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text('Tgl. Dibutuhkan'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            controller: controllerMysqlAdd.requiredDateCtrl,
                            decoration: bookingDecoration(
                                IconButton(onPressed: (){
                                  controllerMysqlAdd.selectDateRequiredBook();
                                },
                                    icon: Icon(Icons.date_range)
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text('Pilih Ruangan'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Obx((){
                            return DropdownButton(
                              hint: Text('Pilih Ruangan'),
                                items: List<DropdownMenuItem>.generate(
                                  controllerMysqlAdd.categories.length, (index) {
                                    return DropdownMenuItem(
                                      child: Text(
                                          controllerMysqlAdd.categories[index].name!
                                      ),
                                      value: controllerMysqlAdd.categories[index].id!,
                                    );
                                }
                                ),
                                value: controllerMysqlAdd.selectedRoom.value,
                                onChanged: (newValue) {
                                  controllerMysqlAdd.selectedRoom.value = newValue;
                                }
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text('Jam Dibutuhkan'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: TextFormField(
                                  controller: controllerMysqlAdd.timeStartCtrl,
                                  decoration: bookingDecoration(
                                      IconButton(onPressed: (){
                                        controllerMysqlAdd.selectTimeStartBook();
                                      },
                                          icon: Icon(Icons.timer_sharp)
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Center(
                                  child: Text('s/d'),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: TextFormField(
                                  controller: controllerMysqlAdd.requiredDateCtrl,
                                  decoration: bookingDecoration(
                                      IconButton(onPressed: (){
                                        controllerMysqlAdd.selectDateRequiredBook();
                                      },
                                          icon: Icon(Icons.timer_sharp)
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          )
        ),
      ),
    );
  }
}
