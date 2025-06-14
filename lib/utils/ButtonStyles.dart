import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF199A8E),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(200),
    ),
    minimumSize: const Size(250, 60),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),);
}
