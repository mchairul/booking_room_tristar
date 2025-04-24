
import 'dart:async';
import 'dart:io';

import 'package:booking_room/helpers/state_data.dart';
import 'package:booking_room/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerSplashScreen extends GetxController {
  late final AuthService _authService;
  late final SharedPreferences _sharedPreferences;

  StateData stateData = Get.put(StateData());

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _sharedPreferences = await SharedPreferences.getInstance();
    _authService = Get.put(AuthService());
    init();
  }

  init() async {
    Timer(const Duration(seconds: 2), () async {
      String authToken = _sharedPreferences.getString('auth_token') ?? '';

      if (authToken != '') {
        //cek token
        final response = await _authService.cekToken(authToken);

        if (response.statusCode == HttpStatus.ok) {
          // menyimpan auth token ke state data
          stateData.authToken.value = authToken;

          Get.offNamed('/home');
          debugPrint('berhasil cek');
        } else {
          Get.offNamed('/login');
          debugPrint('gagal cek');
        }
      } else {
        Get.offNamed('/login');
        debugPrint('token kosong');
      }
    });
  }
}