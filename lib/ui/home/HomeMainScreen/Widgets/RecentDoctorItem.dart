// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Recentdoctoritem extends StatelessWidget {
  const Recentdoctoritem({super.key, required this.DoctorName, required this.DoctorImage, required this.onpressed});
  final String DoctorName ;
  final String DoctorImage;
  final VoidCallback onpressed;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
             decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(DoctorImage))
             ),
          ),
        const   SizedBox(height: 5,),
           Text(DoctorName,style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
      
          ),),
        ],
      ),
    );
  }
}