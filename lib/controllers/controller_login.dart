import 'dart:io';
import 'package:booking_room/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerLogin extends GetxController {
  var formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isEmailEmpty = false.obs;
  RxBool isPasswordEmpty = false.obs;

  late final AuthService _authService;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _authService = Get.put(AuthService());
  }

  prosesLogin(String email, String password) async {
    isLoading.value = true;
    final response = await _authService.prosesLogin(email, password);

    debugPrint(response.body.toString());

    var body = response.body;

    if (response.statusCode == HttpStatus.ok) {

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('auth_token', body['data']['token']);
      String firebaseToken = preferences.getString('firebase_token') ?? '';

      await _authService.sendFirebaseToken(
          body['data']['token'], firebaseToken
      );

      Get.offNamed('/home');
    } else {
      // jika salah form
      if (response.statusCode == HttpStatus.preconditionRequired) {
        var errorEmail = body['data']['email'];
        var errorPassword = body['data']['password'];

        if (errorEmail != null) {
          isEmailEmpty.value = true;
          Get.snackbar(
              "Form Error",
              errorEmail.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.yellow
          );
        }

        if (errorPassword != null) {
          isPasswordEmpty.value = true;
          Get.snackbar(
              "Form Error",
              errorPassword.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.yellow
          );
        }
      } else {
        Get.defaultDialog(
            title: 'Login Gagal',
            middleText: 'Harap Periksa Email dan/atau Password Anda',
            textConfirm: 'ok',
            onConfirm: (){
              Get.back();
            }
        );
      }
    }
    isLoading.value = false;
  }
}
