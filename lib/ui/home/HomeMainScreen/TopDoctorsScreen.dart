import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorDetailedItem.dart';
import 'package:flutter/material.dart';

class Topdoctorsscreen extends StatelessWidget {
  const Topdoctorsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 27,
              color: Colors.black,
            )),
        title: const Text(
          "Top Doctors",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return DoctorDetailedItem(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Doctordetailsscreen();
              }));
            },
            DoctorImage:
                "assets/images/homeScreen/pexels-cedric-fauntleroy-4270371@2x.png",
            DoctorName: "Dr ALi Ebrahim",
            DoctorSpecality: "chardiologist",
            DoctorRating: "4.7",
            distance: "800",
          );
        },
      ),
    );
  }
}
