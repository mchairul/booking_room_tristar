import 'package:booking_room/helpers/state_data.dart';
import 'package:get/get.dart';

class AuthService extends GetConnect {
  StateData stateData = Get.put(StateData());

  Future<Response> prosesLogin(String email, String password) async {
    final response = await post('${stateData.baseUrl}login', {
      'email': email,
      'password': password
    });

    return response;
  }

  // digunakan untuk mengecek token setiap kali memebuka aplikasi
  // # agar tidak login setiap membuka aplikasi
  Future<Response> cekToken(String authToken) async {
    final response = await post('${stateData.baseUrl}check', {},
    headers: {
      'Authorization': 'Bearer $authToken'
    });

    return response;
  }
}