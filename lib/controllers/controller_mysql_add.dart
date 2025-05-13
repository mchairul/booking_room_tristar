import 'package:booking_room/helpers/DbMysql.dart';
import 'package:booking_room/models/category_model.dart';
import 'package:booking_room/models/facility_model.dart';
import 'package:booking_room/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ControllerMysqlAdd extends GetxController{
  final conn = DbMysql();

  RxList<RoomModel> rooms = <RoomModel>[
    RoomModel(
      id: 0,
      name: 'Pilih Ruangan'
    )
  ].obs;

  RxList<CategoryModel> categories = <CategoryModel>[
    CategoryModel(
        id: 0,
        name: 'Pilih Kategori',
        remark: ''
    )
  ].obs;

  RxList<FacilityModel> facilities = <FacilityModel>[].obs;
  RxList<FacilityModel> otherFacilities = <FacilityModel>[].obs;

  var formKey = GlobalKey<FormState>();
  var dateBooking = DateTime.now().obs;
  var requiredDateBooking = DateTime.now().obs;

  var startTime = ''.obs;
  var endTime = ''.obs;
  var selectedRoom = 0.obs;
  var selectedCategory = 0.obs;
  var categoryDescription = ''.obs;

  RxList listParticipants = [].obs;

  RxMap valFacilities = {}.obs;
  RxMap valFacilitiesOther = {}.obs;

  TextEditingController requestDateCtrl = TextEditingController();
  TextEditingController requiredDateCtrl = TextEditingController();
  TextEditingController timeStartCtrl = TextEditingController();
  TextEditingController timeEndCtrl = TextEditingController();

  TextEditingController categoryDescriptionCtrl = TextEditingController();

  TextEditingController addParticipantCtrl = TextEditingController();
  TextEditingController participantsCtrl = TextEditingController();

  TextEditingController keteranganCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getRooms();
    getCategories();
    getFacilities();
    getFacilitiesOther();
  }

  List<CategoryModel> search(int id){
    return categories.where((e) => e.id == id).toList();
  }

  getTextCategory(int id) {
    List<CategoryModel> doSearch = search(id);
    String name = doSearch[0].remark.toString();
    debugPrint(name);
    categoryDescription.value = name;
    categoryDescriptionCtrl.text = name;
  }

  void selectDateRequestBook() async {
    final DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030,12,31)
    );
    if (pickedDate != null) {
      dateBooking.value = pickedDate;
      requestDateCtrl.text = DateFormat('yyyy-MM-dd').format(dateBooking.value)
          .toString();
    }
  }

  void selectDateRequiredBook() async {
    final DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030,12,31)
    );
    if (pickedDate != null) {
      requiredDateBooking.value = pickedDate;
      requiredDateCtrl.text = DateFormat('yyyy-MM-dd')
          .format(requiredDateBooking.value)
          .toString();
    }
  }

  Future getRooms() async {
    debugPrint('Starting getRooms()');
    conn.getConnection().then((connection) async{
      String sql = 'SELECT id, name FROM rooms';
      final res = await connection.query(sql);
      for (var row in res) {
        rooms.add(
          RoomModel(
            id: row['id'],
            name: row['name']
          )
        );
      }
      connection.close();
    });
  }

  Future getCategories() async {
    debugPrint('Starting getCategories()');
    conn.getConnection().then((connection) async {
      String sql = 'SELECT id, name, remarks FROM categories';
      final res = await connection.query(sql);
      for (var row in res) {
        categories.add(
            CategoryModel(
              id: row['id'],
              name: row['name'],
              remark: row['remarks'],
            )
        );
      }
      connection.close();
    });
  }

  Future getFacilities() async {
    debugPrint('Starting getFacilities()');
    conn.getConnection().then((connection) async{
      String sql = 'SELECT id, name FROM facilities';
      final res = await connection.query(sql);
      for (var row in res) {
        facilities.add(
            FacilityModel(
              id: row['id'],
              name: row['name'],
            )
        );
        //valFacilities.assign(row['id'], false);
        valFacilities[row['id']] = false;
      }
      connection.close();
    });
  }

  Future getFacilitiesOther() async {
    debugPrint('Starting getFacilitiesOther()');
    conn.getConnection().then((connection) async{
      String sql = 'SELECT id, name FROM facility_others';
      final res = await connection.query(sql);
      for (var row in res) {
        otherFacilities.add(
            FacilityModel(
              id: row['id'],
              name: row['name'],
            )
        );
        valFacilitiesOther[row['id']] = false;
        connection.close();
      }
    });
  }

  void selectTimeStartBook() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now()
    );
    if (pickedTime != null) {
      startTime.value = pickedTime.format(Get.context!);
      timeStartCtrl.text = pickedTime.format(Get.context!);
    }
  }

  void selectTimeEndBook() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now()
    );
    if (pickedTime != null) {
      endTime.value = pickedTime.format(Get.context!);
      timeEndCtrl.text = pickedTime.format(Get.context!);
    }
  }

  genearateParticipants() {
    String participants = '';
    for (var i in listParticipants) {
      participants += i + ',\n';
    }
    participantsCtrl.text = participants;
  }

  addParticipant() {
    String name = addParticipantCtrl.text;

    if (listParticipants.contains(name)) {
      debugPrint('nama sudah ada');
    } else {
      listParticipants.add(name);
      genearateParticipants();
    }
    addParticipantCtrl.text = '';
  }

  checkFacilities(int id, bool value) {
    valFacilities[id] = value;
  }

  checkFacilitiesOther(int id, bool value) {
    valFacilitiesOther[id] = value;
  }

  Future<void> saveBooking() async {
    var dateRequested = requestDateCtrl.text;
    var requiredDate = requiredDateCtrl.text;
    var room = selectedRoom.value;
    var reqTimeStart = timeStartCtrl.text;
    var reqTimeEnd = timeEndCtrl.text;
    var category = selectedCategory.value;
    var participants = participantsCtrl.text;
    participants = participants.
              replaceAll("\n", "");
    var description = keteranganCtrl.text;

    conn.getConnection().then((connection) async {
      String sql = "INSERT INTO bookings "
          "(users_id,rooms_id,categories_id,"
          "request_date,required_date,time_start,"
          "time_end,participants,description,"
          "created_at,updated_at) VALUES "
          "(1, $room, $category, '$dateRequested',"
          "'$requiredDate', '$reqTimeStart',"
          "'$reqTimeEnd','$participants','$description',"
          "now(), now())";
      final res = await connection.query(sql);
      debugPrint(res.insertId.toString());
      var id = res.insertId;

      //loop facilities
      valFacilities.forEach((key, value) async {
        debugPrint(key.toString());
        debugPrint(value.toString());
        if (value) {
          String sqlFacility = "INSERT INTO booking_facilities "
              "(bookings_id,facilities_id,created_at,updated_at) "
              "VALUES ($id, $key, now(), now())";
          await connection.query(sqlFacility);
        }
      });

      // loop facilities other
      valFacilitiesOther.forEach((key, value) async {
        debugPrint(key.toString());
        debugPrint(value.toString());
        if (value) {
          String sqlFacility = "INSERT INTO booking_facility_others "
              "(bookings_id,facility_others_id,created_at,updated_at) "
              "VALUES ($id, $key, now(), now())";
          await connection.query(sqlFacility);
        }
      });

      connection.close();

      Get.toNamed('/mysql');
    });
  }
}
