import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/RecommendedDoctorItem.dart';
import 'package:flutter/material.dart';

class RecommendedDoctorsListView extends StatelessWidget {
  const RecommendedDoctorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Recommendeddoctoritem(
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
