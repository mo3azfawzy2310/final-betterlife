import 'package:better_life/ui/home/HomeMainScreen/HomeMainScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/ScheduleScreen.dart';
import 'package:better_life/ui/home/messagesTap/messageScreen.dart';
import 'package:better_life/ui/home/pillReminder/pillReminderScreen.dart';
import 'package:better_life/ui/home/profileScreen/profileScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home-Screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
   const Homemainscreen(),
   const MessagesScreen(),
   const Schedulescreen(),
    const PillReminderScreen(),
   const profileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration:const  BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            IconData icon;
            switch (index) {
              case 0:
                icon = Icons.home_outlined;
                break;
              case 1:
                icon = Icons.chat_bubble_outline;
                break;
              case 2:
                icon = Icons.calendar_month_outlined;
                break;
              case 3:
                icon = Icons.schedule;
                break;
              case 4:
                icon = Icons.person_outline;
                break;
              default:
                icon = Icons.home_outlined;
            }

            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: isSelected
                    ? BoxDecoration(
                  color: const Color(0xFF199A8E).withOpacity(0.15),
                  shape: BoxShape.circle,
                )
                    : null,
                child: Icon(
                  icon,
                  size: 28,
                  color: isSelected ? const Color(0xFF199A8E) : Colors.grey,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
