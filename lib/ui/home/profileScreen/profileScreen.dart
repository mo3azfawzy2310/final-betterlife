import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/ui/home/profileScreen/buildProfileItems.dart';
import 'package:better_life/ui/home/profileScreen/profileData.dart';
import 'package:better_life/ui/home/profileScreen/showLogOutDialog.dart';
import 'package:better_life/ui/home/profileScreen/settingTap/SettingScreen.dart';
import 'package:better_life/ui/home/profileScreen/PaymentMethod/paymentMethod.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile-screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final loadedUser = await AppPreferences().getModel<UserModel>(
      'userModel',
          (json) => UserModel.fromJson(json),
    );
    setState(() {
      user = loadedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userName = user?.displayName ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xFF199A8E),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              profileData(
                  value: "215bpm", icon: Icons.favorite, label: "Heart rate"),
              profileData(
                  value: "756cal",
                  icon: Icons.local_fire_department,
                  label: "Calories"),
              profileData(
                  value: "103lbs", icon: Icons.fitness_center, label: "Weight"),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                children: [
                  buildProfileItems(Icons.bookmark, "My Saved", () {}),
                  buildProfileItems(Icons.payment, "Payment Method", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PaymentMethodScreen()),
                    );
                  }),
                  buildProfileItems(Icons.settings, "Settings", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SettingScreen()),
                    );
                  }),
                  buildProfileItems(Icons.logout, "Logout", () {
                    LogOutDialog.showLogOutDialog(context);
                  }, isLogout: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
