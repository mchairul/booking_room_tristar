
import 'package:booking_room/helpers/state_data.dart';
import 'package:get/get.dart';

class BookingService extends GetConnect {
  StateData stateData = Get.put(StateData());

  Future<Response> listBookings() async {
    final response = await get('${stateData.baseUrl}bookings',
      headers: {
        'Authorization': 'Bearer ${stateData.authToken.value}',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    );

    return response;
  }

  Future<Response> detailBooking(String id) async {
    final response = await get('${stateData.baseUrl}booking/$id',
        headers: {
          'Authorization': 'Bearer ${stateData.authToken.value}',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
    );

    return response;
  }

  Future<Response> approveBooking(int id) async {
    final response = await patch('${stateData.baseUrl}booking/approve/${id.toString()}',
        {},
    headers: {
      'Authorization': 'Bearer ${stateData.authToken.value}',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });

    return response;
  }

  Future<Response> logout() async {
    final response = await get('${stateData.baseUrl}logout',
        headers: {
          'Authorization': 'Bearer ${stateData.authToken.value}',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });

    return response;
  }

  Future<Response> facilities() async {
    final response = await get('${stateData.baseUrl}facilities',
        headers: {
          'Authorization': 'Bearer ${stateData.authToken.value}',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
    );

    return response;
  }

  Future<Response> rooms() async {
    final response = await get('${stateData.baseUrl}rooms',
        headers: {
          'Authorization': 'Bearer ${stateData.authToken.value}',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
    );

    return response;
  }
}
