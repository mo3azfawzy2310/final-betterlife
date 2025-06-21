// ignore_for_file: camel_case_types

import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TopDoctorsListView.dart';
import 'package:flutter/material.dart';

class TopDectors_Section extends StatelessWidget {
  const TopDectors_Section({
    super.key, 
    required this.SeeALl_onPressed, 
    required this.doctors,
    this.onDoctorSelected,
  });
  
  final VoidCallback SeeALl_onPressed;
  final List<DoctorModel> doctors;
  final Function(DoctorModel doctor)? onDoctorSelected;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Top Doctors",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child:
                    TextButton(onPressed: SeeALl_onPressed, child: const Text("See All"))),
          ],
        ),
        const SizedBox(height: 20,),
        Topdoctorslistview(
          doctors: doctors,
          onDoctorSelected: onDoctorSelected,
        )
      ],
    );
  }
}
