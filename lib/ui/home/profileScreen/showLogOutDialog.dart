import 'package:better_life/ui/login_signup/loginScreen/loginScreen.dart';
import 'package:flutter/material.dart';

class LogOutDialog{
  LogOutDialog(BuildContext context);

  static void showLogOutDialog (BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_)=>Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout,size: 40,color: Color(0xFF199A8E),),
              ),
              const SizedBox(height: 20,),
              const Text(
                "are you sure to Log out from your account?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: 183,
                height: 56,
                child: ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF199A8E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                    child: const Text("Log Out",
                    style:TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ) ,
                    ),
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                  onPressed: ()=>Navigator.pop(context),
                  child:const Text("Cancel",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: Color(0xFF199A8E)),)),
            ],
          ),
          ),
        ),
    );
  }
}