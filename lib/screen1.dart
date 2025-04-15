import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Screen1 extends StatelessWidget {
  RxBool isDarkMode = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Screen 1'),
            ElevatedButton(
                onPressed: (){
                  Get.offNamed('/screen2');
                },
                child: Text('Move to Screen 2')
            ),
            Obx(
                () => Text(
                  'Current Mode ${isDarkMode.isTrue ? 'dark' : 'light'} '
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ObxValue((data)=> Switch(
                    value: isDarkMode.isTrue,
                    onChanged: (val){
                      isDarkMode.value = val;
                      Get.changeThemeMode(
                          isDarkMode.isTrue ? ThemeMode.dark :
                          ThemeMode.light
                      );
                    }
                ), false.obs),
                Icon(Icons.dark_mode)
              ],
            )
          ],
        ),
      ),
    );
  }
}
