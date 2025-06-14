import 'package:better_life/ui/home/HomeMainScreen/Widgets/FindDoctorSearch_TextField.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/RecentdoctorListView.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/RecommendedDoctorsListView.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/categortItemsGridView.dart';
import 'package:flutter/material.dart';

class Finddoctorsscreen extends StatelessWidget {
  const Finddoctorsscreen({super.key});

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
            "Find Doctors",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FinddoctorsearchTextfield(),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                categortItemsGridView(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Recommended Doctors",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                RecommendedDoctorsListView(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your Recent Doctors",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
               RecentdoctorListView()
              ],
            ),
          ),
        ));
  }
}
