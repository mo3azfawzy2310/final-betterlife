import 'package:flutter/material.dart';

class Doctorrating extends StatelessWidget {
  const Doctorrating({super.key, required this.DoctorRating});
  final String DoctorRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 25,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0XFFE8F3F1),
      ),
      child: Row(
        children: [
         const  Icon(Icons.star, color:  Color(0xFF199A8E), size: 15,),
        const  SizedBox(width: 5,),
          Text(DoctorRating,style:const  TextStyle(color:  Color(0xFF199A8E),fontSize: 15,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}