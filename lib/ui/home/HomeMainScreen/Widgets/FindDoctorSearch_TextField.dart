import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FinddoctorsearchTextfield extends StatelessWidget {
  const FinddoctorsearchTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      decoration: InputDecoration(
        fillColor:const  Color(0xffFBFBFB),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:const  BorderSide(color: Color.fromARGB(255, 218, 217, 217))
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:const  BorderSide(color: Color.fromARGB(255, 218, 217, 217))
        ),
        prefixIcon:const  Icon(FontAwesomeIcons.magnifyingGlass,color: Color(0xffADADAD),size: 25,)  // search icon,
        ,hintText: "Find a doctor",
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xffADADAD)
        ),
    
      ),
    );
  }
}