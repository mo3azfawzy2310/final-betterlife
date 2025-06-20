import 'package:better_life/ui/home/HomeMainScreen/Widgets/TopSection.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/sheduleItem.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/status_tab_bar.dart';
import 'package:flutter/material.dart';

class Schedulescreen extends StatefulWidget {
  const Schedulescreen({super.key});

  @override
  State<Schedulescreen> createState() => _SchedulescreenState();
}

class _SchedulescreenState extends State<Schedulescreen> {
  int _selectedIndex = 0;

  final List<String> _tabs = ['Upcoming', 'Completed', 'Canceled'];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Topsection(
                Notifications_Onpressed: () {},
                text: 'Schedule',
              ),
              StatusTabBar(
                tabs: _tabs,
                selectedIndex: _selectedIndex,
                onTabSelected: _onTabSelected,
              ),
              const SizedBox(height: 20),
          const  sheduleItem(
                  DoctorName: "Dr. ALi Ebrahim",
                  Spaclist: "chardiologist",
                  DoctorImage:
                      'assets/images/homeScreen/pexels-cedric-fauntleroy-4270371@2x.png',
                  Date: "11/11/2022",
                  time: "10:00 AM"),
              const SizedBox(
                height: 35,
              ),
              const sheduleItem(
                  DoctorName: "Dr. Salem",
                  Spaclist: "chardiologist",
                  DoctorImage: "assets/images/homeScreen/Mask Group.png",
                  Date: "26/06/2022",
                  time: "20:40 AM")
            ],
          ),
        ),
      ),
    );
  }
}
