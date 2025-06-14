import 'package:flutter/material.dart';

class LearnmoreBotton extends StatelessWidget {
  const LearnmoreBotton({super.key, required this.LearmMore_OnPressed});
  final VoidCallback LearmMore_OnPressed;

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color:const  Color(0xFF199A8E),
      onPressed: LearmMore_OnPressed,
      child:const  Text("Learn more",style: TextStyle(color: Colors.white,fontSize: 14),),
      );
  }
}