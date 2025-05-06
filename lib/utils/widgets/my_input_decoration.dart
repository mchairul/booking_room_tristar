import 'package:flutter/material.dart';

InputDecoration myInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5))
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5))
    ),
  );
}

InputDecoration bookingDecoration(IconButton? suffix) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))
    ),
    suffixIcon: suffix
  );
}
