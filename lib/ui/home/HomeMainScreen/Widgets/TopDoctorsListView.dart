import 'package:better_life/models/home_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorItem.dart';
import 'package:flutter/material.dart';

class Topdoctorslistview extends StatelessWidget {
  final List<DoctorModel> doctors;

  const Topdoctorslistview({
    Key? key,
    required this.doctors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: DoctorItem(
              onpressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Doctordetailsscreen(); // لو حابب تمرر الدكتور
                  },
                ));
              },
              DoctorImage: doctor.pictureUrl,
              DoctorName: doctor.name,
              DoctorSpeciality: doctor.speciality,
              DoctorRating: doctor.rate.toStringAsFixed(1),
              distance: "800", // لو عندك قيمة distance حقيقية حطها هنا
            ),
          );
        },
      ),
    );
  }
}
