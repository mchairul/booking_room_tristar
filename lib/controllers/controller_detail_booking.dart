
import 'package:booking_room/services/booking_service.dart';
import 'package:get/get.dart';

class ControllerDetailBooking extends GetxController {
  late final BookingService _bookingService;
  RxString idBooking = '0'.obs;
  String id = Get.parameters['id'] ?? '';

  RxString roomName = ''.obs;
  RxString categoryName = ''.obs;
  RxString categoryRemarks = ''.obs;


  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idBooking.value = id;
    _bookingService = Get.put(BookingService());
    getDetailBooking();
  }

  getDetailBooking() async {
    isLoading.value = true;
    final response = await  _bookingService.detailBooking(idBooking.value);
    print(response);
    roomName.value = response.body['data']['room_name'];
    categoryName.value = response.body['data']['category_name'];
    categoryRemarks.value = response.body['data']['category_remarks'];

  }
}