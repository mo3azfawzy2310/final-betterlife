import 'package:better_life/core/services/user_service.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/ui/home/pillReminder/pillReminderScreen.dart';
import 'package:better_life/ui/home/profileScreen/settingTap/SettingScreen.dart';
import 'package:better_life/ui/home/profileScreen/buildProfileItems.dart';
import 'package:better_life/ui/home/profileScreen/profileData.dart';
import 'package:better_life/ui/home/profileScreen/showLogOutDialog.dart';
import 'package:better_life/ui/home/profileScreen/saved_blogs_screen.dart';
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
          const SizedBox(height: 60),
          
          // Profile header
          _buildProfileHeader(),
          
          const SizedBox(height: 16),
          
          // Health metrics
          _buildHealthMetrics(),
          
          const SizedBox(height: 32),
          
          // Profile options
          Expanded(
            child: _buildProfileOptions(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Profile picture
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white70,
          backgroundImage: AssetImage("assets/images/homeScreen/Doctor.png"),
          child: isLoading ? const CircularProgressIndicator() : null,
        ),
        const SizedBox(height: 12),
        
        // User name
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
        
        // User email
        if (currentUser?.email != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              currentUser!.email,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHealthMetrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        profileData(
          value: "72bpm",
          icon: Icons.favorite,
          label: "Heart rate",
        ),
        profileData(
          value: "756cal",
          icon: Icons.local_fire_department,
          label: "Calories",
        ),
        profileData(
          value: "103lbs",
          icon: Icons.fitness_center,
          label: "Weight",
        ),
      ],
    );
  }

  Widget _buildProfileOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ListView(
        children: [
          // Saved Articles
          buildProfileItems(
            Icons.bookmark,
            "My Saved Articles",
            () {
              Navigator.pushNamed(context, SavedBlogsScreen.routeName);
            },
          ),
          
          // Notifications
          buildProfileItems(
            Icons.notifications,
            "Notifications",
            () {
              Navigator.pushNamed(context, NotificationsScreen.routeName);
            },
          ),
          
          // Medical Records
          buildProfileItems(
            Icons.medical_services,
            "Medical Records",
            () {
              Navigator.pushNamed(context, MedicalRecordsScreen.routeName);
            },
          ),
          
          // Payment Method
          buildProfileItems(
            Icons.payment,
            "Payment Method",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
              );
            },
          ),
          
          // Pill Reminder
          buildProfileItems(
            Icons.medication,
            "Pill Reminder",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PillReminderScreen()),
              );
            },
          ),
          
          // Settings
          buildProfileItems(
            Icons.settings,
            "Settings",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
          ),
          
          // Debug - API Test
          buildProfileItems(
            Icons.bug_report,
            "API Test (Debug)",
            () {
              Navigator.pushNamed(context, '/api-test');
            },
          ),
          
          // Logout
          buildProfileItems(
            Icons.logout,
            "Logout",
            () {
              LogOutDialog.showLogOutDialog(context);
            },
            isLogout: true,
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
