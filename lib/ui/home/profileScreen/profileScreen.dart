import 'package:better_life/core/services/user_service.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/ui/home/pillReminder/pillReminderScreen.dart';
import 'package:better_life/ui/home/profileScreen/settingTap/SettingScreen.dart';
import 'package:better_life/ui/home/profileScreen/buildProfileItems.dart';
import 'package:better_life/ui/home/profileScreen/profileData.dart';
import 'package:better_life/ui/home/profileScreen/showLogOutDialog.dart';
import 'package:flutter/material.dart';

import 'PaymentMethod/paymentMethod.dart';
import '../notifications/notifications_screen.dart';
import '../medical_records/medical_records_screen.dart';

class profileScreen extends StatefulWidget {
  static const String routeName = 'profile-screen';

  const profileScreen({super.key});
  
  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  UserModel? currentUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await UserService.getCurrentUser();
      if (mounted) {
        setState(() {
          currentUser = user;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF199A8E),
      body: Column(
        children: [
          const SizedBox(height:60,),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white70,
            backgroundImage: AssetImage("assets/images/homeScreen/Doctor.png"), // Placeholder image
            child: isLoading ? const CircularProgressIndicator() : null,
          ),
          const SizedBox(height: 12,),
          isLoading 
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              currentUser?.displayName ?? "User",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [ // Health metrics data (placeholder)
              profileData(value: "215bpm", icon: Icons.favorite, label: "Heart rate"),
              profileData(value: "756cal", icon: Icons.local_fire_department, label: "Calories"),
              profileData(value: "103lbs", icon: Icons.fitness_center, label: "weight"),
            ],
          ),
          const SizedBox(height: 32,),
          Expanded(
            child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
              child: ListView(
                children: [
                  buildProfileItems(Icons.bookmark, "MySaved", (){}),
                  buildProfileItems(Icons.notifications, "Notifications", (){
                    Navigator.pushNamed(context, NotificationsScreen.routeName);
                  }),
                  buildProfileItems(Icons.medical_services, "Medical Records", (){
                    Navigator.pushNamed(context, MedicalRecordsScreen.routeName);
                  }),
                  buildProfileItems(Icons.payment, "Payment Method", (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
                    );
                  }),
                  buildProfileItems(Icons.settings, "Settings", (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> SettingScreen(),),
                    );
                  }),
                  buildProfileItems(Icons.bug_report, "API Test (Debug)", (){
                    Navigator.pushNamed(context, '/api-test');
                  }),
                  buildProfileItems(Icons.logout, "Logout", (){
                    LogOutDialog.showLogOutDialog(context);
                  },isLogout: true
                  ),
                ],
              ),
          ),
          ),
       ],
      ),
    );
  }
}

// Add this class for backward compatibility with main.dart
class ProfileScreen extends profileScreen {
  const ProfileScreen({Key? key}) : super(key: key);
  
  static const String routeName = "profile-screen";
}
