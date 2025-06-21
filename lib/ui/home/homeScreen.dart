import 'package:better_life/ui/home/homeTap.dart';
import 'package:better_life/ui/home/HomeMainScreen/ScheduleScreen.dart';
import 'package:better_life/ui/home/messagesTap/messageScreen.dart';
import 'package:better_life/ui/home/profileScreen/profileScreen.dart';
import 'package:better_life/ui/logic/appointment/appointment_cubit.dart';
import 'package:better_life/ui/logic/doctors/doctors_cubit.dart';
import 'package:better_life/ui/logic/home/homecubit_cubit.dart';
import 'package:better_life/ui/logic/medical_records/medical_records_cubit.dart';
import 'package:better_life/ui/logic/notifications/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "Home-Screen";
  
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomecubitCubit()),
        BlocProvider(create: (context) => AppointmentCubit()),
        BlocProvider(create: (context) => DoctorsCubit()..getAllDoctors()),
        BlocProvider(create: (context) => MedicalRecordsCubit()),
        BlocProvider(create: (context) => NotificationsCubit()),
      ],
      child: const Homemain(),
    );
  }
}

class Homemain extends StatefulWidget {
  const Homemain({Key? key}) : super(key: key);

  @override
  State<Homemain> createState() => _HomemainState();
}

class _HomemainState extends State<Homemain> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const HomeTap(),
    const MessageScreen(),
    const ScheduleScreen(),
    const ProfileScreen(),
  ];
  
  // Method to switch tabs - can be called from other widgets
  void switchToTab(int index) {
    if (index >= 0 && index < screens.length) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  // Helper method to switch to the schedule tab specifically
  void switchToScheduleTab() {
    switchToTab(2); // Index 2 is the Schedule tab
  }

  @override
  Widget build(BuildContext context) {
    // Provide a global key to access this state from outside
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
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
                icon = Icons.person_outline;
                break;
              default:
                icon = Icons.home_outlined;
            }

            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                switchToTab(index);
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
