import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorItem.dart';
import 'package:flutter/material.dart';

class Topdoctorslistview extends StatelessWidget {
  final List<DoctorModel> doctors;
  final Function(DoctorModel doctor)? onDoctorSelected;

  const Topdoctorslistview({
    Key? key,
    required this.doctors,
    this.onDoctorSelected,
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
                if (onDoctorSelected != null) {
                  // Use the callback if provided
                  onDoctorSelected!(doctor);
                } else {
                  // Default navigation behavior
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return DoctorDetailsScreen(doctor: doctor);
                    },
                  ));
                }
              },
              DoctorImage: doctor.pictureUrl,
              DoctorName: doctor.name,
              DoctorSpeciality: doctor.speciality,
              DoctorRating: doctor.rating.toStringAsFixed(1),
              distance: "800", // If you have a real distance value, use it here
            ),
          );
        },
      ),
    );
  }
}
