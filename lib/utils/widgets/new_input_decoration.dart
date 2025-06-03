import 'package:flutter/material.dart';

InputDecoration newInputDecoration (String hint, {String? errorText}) {
  return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      errorText: errorText
  );
}
