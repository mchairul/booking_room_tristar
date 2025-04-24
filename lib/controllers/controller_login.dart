import 'dart:io';
import 'package:booking_room/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerLogin extends GetxController {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late final AuthService _authService;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _authService = Get.put(AuthService());
  }

  prosesLogin(String email, String password) async {
    final response = await _authService.prosesLogin(email, password);

    debugPrint(response.body.toString());

    if (response.statusCode == HttpStatus.ok) {
      var body = response.body;

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('auth_token', body['access_token']);

      Get.offNamed('/home');
    } else {
      Get.defaultDialog(
        middleText: 'Login Gagal',
        textConfirm: 'ok',
        onConfirm: (){
          Get.back();
        }
      );
    }
  }
}
