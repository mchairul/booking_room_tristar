import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerLogin extends GetxController {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  prosesLogin(String email, String password){
    Get.defaultDialog(
      middleText: 'Email : ${email} , \n Password : ${password}',
      textConfirm: 'ok',
      onConfirm: (){
        Get.back();
      }
    );
  }
}
