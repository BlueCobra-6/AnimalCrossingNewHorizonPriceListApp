import 'package:flutter/material.dart';

ShapeBorder unfocusedInputBorder(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
    borderSide: BorderSide(color: Colors.grey[400]),
  );
}