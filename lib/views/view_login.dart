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
                      decoration: myInputDecoration('email'),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: controllerLogin.passwordController,
                      decoration: myInputDecoration('Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: (){
                            controllerLogin.prosesLogin(
                                controllerLogin.emailController.text,
                                controllerLogin.passwordController.text
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: Text('Login')
                      ),
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
