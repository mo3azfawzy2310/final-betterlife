// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Cancel_reschduleBotton extends StatelessWidget {
  const Cancel_reschduleBotton({super.key, required this.onpressed, required this.text, required this.containercolor, required this.textcolor});
  final VoidCallback onpressed;
  final String text;
  final Color containercolor;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressed,
      color: containercolor,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Text(text,style: TextStyle(color: textcolor,fontSize: 16),),
      
    );
  }
}