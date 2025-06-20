import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/authProvider.dart';
import 'PaymentMethod/paymentMethod.dart';
import 'settingTap/SettingScreen.dart';
import 'buildProfileItems.dart';
import 'profileData.dart';
import 'showLogOutDialog.dart';

class profileScreen extends StatelessWidget {
  static const String routeName = 'profile-screen';

  const profileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final userName = auth.displayName ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xFF199A8E),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/images/user_avatar.png"), // لو مش عندك الصورة، استخدم أي واحدة مؤقتًا
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
              profileData(value: "215bpm", icon: Icons.favorite, label: "Heart rate"),
              profileData(value: "756cal", icon: Icons.local_fire_department, label: "Calories"),
              profileData(value: "103lbs", icon: Icons.fitness_center, label: "Weight"),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                children: [
                  buildProfileItems(Icons.bookmark, "My Saved", () {}),
                  buildProfileItems(Icons.payment, "Payment Method", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodScreen()));
                  }),
                  buildProfileItems(Icons.settings, "Settings", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingScreen()));
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
