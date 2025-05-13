import 'package:booking_room/controllers/controller_mysql_add.dart';
import 'package:booking_room/models/facility_model.dart';
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
            child: Column(
              children: [
                SizedBox(height: 50,),
                Form(key: controllerMysqlAdd.formKey,child: Column(
                  children: [
                    //tanggal diminta
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
                    //tanggal dibutuhkan
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
                    //Pilih Ruangan
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text('Pilih Ruangan'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Obx((){
                            return DropdownButtonFormField(
                              decoration: dropdownDecoration(),
                              hint: Text('Pilih Ruangan'),
                                items: List<DropdownMenuItem>.generate(
                                  controllerMysqlAdd.rooms.length, (index) {
                                    return DropdownMenuItem(
                                      value: controllerMysqlAdd.rooms[index].id!,
                                      child: Text(
                                          controllerMysqlAdd.rooms[index].name!
                                      ),
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
                    //Jam Dibutuhkan
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text('Jam Dibutuhkan'),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: controllerMysqlAdd.timeStartCtrl,
                                decoration: bookingDecoration(
                                    IconButton(onPressed: (){
                                      controllerMysqlAdd.selectTimeStartBook();
                                    },
                                        icon: Icon(Icons.timer_sharp)
                                    )
                                ),
                              ),
                              Center(
                                child: Text('s/d'),
                              ),
                              TextFormField(
                                controller: controllerMysqlAdd.timeEndCtrl,
                                decoration: bookingDecoration(
                                    IconButton(onPressed: (){
                                      controllerMysqlAdd.selectTimeEndBook();
                                    },
                                        icon: Icon(Icons.timer_sharp)
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    //kategori
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text('Pilih Kategori'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Obx((){
                            return DropdownButtonFormField(
                                decoration: dropdownDecoration(),
                                hint: Text('Pilih Kategori'),
                                items: List<DropdownMenuItem>.generate(
                                    controllerMysqlAdd.categories.length, (index) {
                                  return DropdownMenuItem(
                                    value: controllerMysqlAdd.categories[index].id!,
                                    child: Text(
                                        controllerMysqlAdd.categories[index].name!
                                    ),
                                  );
                                }
                                ),
                                value: controllerMysqlAdd.selectedCategory.value,
                                onChanged: (newValue) {
                                  controllerMysqlAdd.selectedCategory.value = newValue;
                                  controllerMysqlAdd.getTextCategory(newValue);
                                }
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    //ket kategori
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text('Ket. Kategori'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            decoration: myInputDecoration(''),
                            controller: controllerMysqlAdd.categoryDescriptionCtrl,
                            maxLines: 5,
                            minLines: 3,
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    // Daftar Peserta
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text('Daftar Peserta'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.remove),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: TextFormField(
                                  decoration: myInputDecoration(''),
                                  controller: controllerMysqlAdd.addParticipantCtrl,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: IconButton(
                                  onPressed: (){
                                    controllerMysqlAdd.addParticipant();
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    // List Daftar Peserta
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(''),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            decoration: myInputDecoration(''),
                            controller: controllerMysqlAdd.participantsCtrl,
                            maxLines: 5,
                            minLines: 3,
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    //Sarana
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Sarana Yang Dibutuhkan'),
                    ),
                    Obx((){
                      return Container(
                        height: (55 * controllerMysqlAdd.facilities.length).toDouble(),
                        child: ListView.builder(
                          itemCount: controllerMysqlAdd.facilities.length,
                          itemBuilder: (BuildContext context, int index) {
                            FacilityModel data = controllerMysqlAdd.facilities[index];
                            return CheckboxListTile(
                                title: Text(data.name!),
                                value: false,
                                onChanged: (value) {
                                  debugPrint(value.toString());
                                  controllerMysqlAdd.valFacilities[data.id] = value;
                                }
                            );
                          },
                        ),
                      );
                    }),
                    SizedBox(height: 20,),
                    //Sarana Lain
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Sarana Lain'),
                    ),
                    Obx((){
                      return Container(
                        height: (55 * controllerMysqlAdd.otherFacilities.length).toDouble(),
                        child: ListView.builder(
                          itemCount: controllerMysqlAdd.otherFacilities.length,
                          itemBuilder: (BuildContext context, int index) {
                            FacilityModel data = controllerMysqlAdd.otherFacilities[index];
                            return CheckboxListTile(
                                title: Text(data.name!),
                                value: false,
                                onChanged: (value) {
                                  debugPrint(value.toString());
                                  controllerMysqlAdd.valFacilitiesOther[data.id] = value;
                                }
                            );
                          },
                        ),
                      );
                    }),
                    SizedBox(height: 20,),
                    //Sarana Lain
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Keterangan'),
                    ),
                    TextFormField(
                      decoration: myInputDecoration(''),
                      controller: controllerMysqlAdd.keteranganCtrl,
                      maxLines: 5,
                      minLines: 3,
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: (){
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: (){
                          },
                          child: Text('Save'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white
                          ),
                        )
                      ],
                    )
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
