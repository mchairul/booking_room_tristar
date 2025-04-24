import 'package:flutter/material.dart';

class ViewHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ini Halaman Home')
          ],
        ),
      ),
    );
  }
}
