// ignore_for_file: must_be_immutable

import 'package:better_life/ui/home/HomeMainScreen/Widgets/DistanceFromDoctor.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorRating.dart';
import 'package:flutter/material.dart';

class DoctorDetailedItem extends StatelessWidget {
  DoctorDetailedItem(
      {super.key,
      required this.DoctorImage,
      required this.DoctorName,
      required this.DoctorSpecality,
      required this.DoctorRating,
      this.onPressed});
  final String DoctorImage;
  final String DoctorName;
  final String DoctorSpecality;
  final String DoctorRating;

  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 210,
        child: Row(
          children: [
            Container(
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(DoctorImage),
                    ))),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DoctorName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  DoctorSpecality,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Doctorrating(
                  DoctorRating: DoctorRating,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
