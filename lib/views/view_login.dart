import 'package:booking_room/controllers/controller_login.dart';
import 'package:booking_room/utils/widgets/my_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewLogin extends StatelessWidget {
  final ControllerLogin controllerLogin = Get.put(ControllerLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 100,),
              Align(
                alignment: Alignment.center,
                child: Text('Login'),
              ),
              SizedBox(height: 30,),
              Form(
                key: controllerLogin.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerLogin.emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        errorText: controllerLogin.isEmailEmpty.value ?
                        'Email Tidak Boleh Kosong' : null
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email Tidak Boleh Kosong";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: controllerLogin.passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        errorText: controllerLogin.isPasswordEmpty.value ?
                            'Password Tidak Boleh Kosong' : null
                      ),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password Tidak Boleh Kosong";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Obx((){
                        return controllerLogin.isLoading.value ? Center(
                          child: SizedBox(
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ) : ElevatedButton(
                            onPressed: () {
                              // jika form sudah tervalidasi
                              if (controllerLogin.formKey.currentState!.validate()){
                                controllerLogin.prosesLogin(
                                    controllerLogin.emailController.text,
                                    controllerLogin.passwordController.text
                                );
                              } else {
                                Get.snackbar(
                                  "Form Error",
                                  "Harap Lengkapi Semua Input",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.yellow
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Login')
                        );
                      }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: (){
                          Get.toNamed('/mysql');
                        },
                        child: Text('MySql')
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
