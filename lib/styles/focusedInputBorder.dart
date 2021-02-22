import 'package:flutter/material.dart';

ShapeBorder focusedInputBorder(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
    borderSide: BorderSide(color: Colors.blue[400]),
  );
}