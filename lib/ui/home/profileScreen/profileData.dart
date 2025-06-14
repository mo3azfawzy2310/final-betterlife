import 'package:flutter/material.dart';

class profileData extends StatelessWidget{
  final IconData icon;
  final String value;
  final String label;
  const profileData({super.key, required this.value,required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon,color: Colors.white,),
        const SizedBox(height: 4,),
        Text(
         value,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70,fontSize: 12),
        )
      ],
    );
  }

}