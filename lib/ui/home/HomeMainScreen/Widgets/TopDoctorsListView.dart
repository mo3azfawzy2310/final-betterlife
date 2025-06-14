import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorItem.dart';
import 'package:flutter/material.dart';

class Topdoctorslistview extends StatelessWidget {
  const Topdoctorslistview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.only(right: 10),
            child:  DoctorItem(
              onpressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Doctordetailsscreen();
                  }));
              },
                DoctorImage:
                    "assets/images/homeScreen/pexels-cedric-fauntleroy-4270371@2x.png",
                DoctorName: "Dr ALi Ebrahim",
                DoctorSpeciality: "chardiologist",
                DoctorRating: "4.7",
                distance: "800"),
          );
        },
      ),
    );
  }
}
