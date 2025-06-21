import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/RecentDoctorItem.dart';
import 'package:flutter/material.dart';
import 'package:better_life/models/doctor_model.dart';

class RecentdoctorListView extends StatelessWidget {
  const RecentdoctorListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Recentdoctoritem(
                onpressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DoctorDetailsScreen(
                      doctor: DoctorModel(
                        id: 1,
                        name: "Dr. Marcus Horizon",
                        speciality: "Chardiologist",
                        rating: 4.7,
                        reviewCount: 124,
                        yearsOfExperience: 10,
                        patientCount: 1000,
                        newVisitPrice: 120,
                        email: "marcus@example.com",
                        phone: "+1234567890"
                      )
                    );
                  }));
                },
                DoctorName: "Dr. Amir",
                DoctorImage: "assets/images/homeScreen/Mask Group.png"),
          );
        },
      ),
    );
  }
}
