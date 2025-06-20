// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentShowDailog  {
static void showAutoCloseDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // علشان المستخدم ميقفلهاش بإيده
      builder: (context) {
        // بعد ثانية، نقفل الـ dialog
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return AlertDialog(
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
            
            borderRadius: BorderRadius.circular(20),
          ),
          content:   SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               const  SizedBox(height: 50,),
               Container(
                          width: 100,
                          height: 100,
                          decoration:const  BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffF5F8FF)
                          ),
                          child:const  Icon(FontAwesomeIcons.check,size: 50,),
               ),
               const  SizedBox(height: 50),
              const   Text("Payment Success",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
             const   SizedBox(height: 50,)
              ],
            ),
          ),
        );
      },
    );
  }}