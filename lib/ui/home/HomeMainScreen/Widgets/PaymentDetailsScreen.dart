import 'package:flutter/material.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
            "Payment Detail",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Consultation",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Spacer(),
              Text("160 L.E",style: TextStyle(color: Colors.black,fontSize: 18),),
            ],
          ),
          SizedBox(height: 5,),
            Row(
            children: [
              Text("Admin Fee",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Spacer(),
              Text("20 L.E",style: TextStyle(color: Colors.black,fontSize: 18),),
            ],
          ),
             SizedBox(height: 5,),
            Row(
            children: [
              Text("Additional Discount",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Spacer(),
              Text("-",style: TextStyle(color: Colors.black,fontSize: 18),),
            ],
          )
      ],
    );
  }
}