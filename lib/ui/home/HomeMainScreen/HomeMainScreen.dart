import 'package:better_life/ui/home/HomeMainScreen/TopDoctorsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/EarlyProtection_Container.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/HealthArticles_Section.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TopDectors_Section.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TopSection.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/Search_Container.dart';
import 'package:flutter/material.dart';

class Homemainscreen extends StatelessWidget {
  const Homemainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Topsection(Notifications_Onpressed: (){},text: 'Find your desire\nhealth solution',),      // Top Section contains Text and Notification Icon,
                const SizedBox(height: 25,),
                const Search_Container(),
                const SizedBox(height: 30,),
                const EarlyProtection_Container(),
                const SizedBox(height: 15,),
                TopDectors_Section(SeeALl_onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) {return const Topdoctorsscreen();},));},),
                const SizedBox(height: 15,),
                HealthArticles_Section(SeeAll_onPressed: () {},),


              ],
            ),
          ),
        ),
      ),
    );
  }
}