import 'package:flutter/material.dart';

class Distancefromdoctor extends StatelessWidget {
  const Distancefromdoctor({super.key, required this.distance});
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Color(0xff3B4453), size: 18,),
        
        FittedBox(child: SizedBox(
          width: 80,
          child: Text("${distance}m away",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:  const TextStyle(color:  Color(0xff3B4453),fontSize: 15,fontWeight: FontWeight.bold),))),
      ],
    );
  }
}