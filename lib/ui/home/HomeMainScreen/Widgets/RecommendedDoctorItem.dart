// ignore_for_file: non_constant_identifier_names

import 'package:better_life/ui/home/HomeMainScreen/Widgets/DistanceFromDoctor.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorRating.dart';
import 'package:flutter/material.dart';

class Recommendeddoctoritem extends StatelessWidget {
  const Recommendeddoctoritem(
      {super.key,
      required this.DoctorImage,
      required this.DoctorName,
      required this.DoctorSpeciality,
      required this.DoctorRating,
      required this.distance, required this.onpressed});
  final String DoctorImage;
  final String DoctorName;
  final String DoctorSpeciality;
  final String DoctorRating;
  final String distance;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20),
        width: 350,
        height: 155,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(children: [
          Container(
            // doctor image
            width: 110,
            height: 110,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(DoctorImage),
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                DoctorName,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DoctorSpeciality,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.grey),
              ),
            const   SizedBox(
                width: 180,
                child: Divider(
                  color: Colors.grey,
                
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Doctorrating(
                    DoctorRating: DoctorRating,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Distancefromdoctor(
                    distance: distance,
                  )
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
