import 'package:better_life/providers/authProvider.dart';
import 'package:better_life/ui/home/homeScreen.dart';
import 'package:better_life/ui/welcome_pages/onboardingScreen/onboardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'Splash Screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateBasedOnToken();
  }

  Future<void> navigateBasedOnToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // ندي شوية وقت لعرض اللوجو قبل ما ننتقل
    await Future.delayed(const Duration(seconds: 3));

    if (token != null && token.isNotEmpty) {
      // تم تسجيل الدخول قبل كده
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      // أول مرة يدخل
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: theme.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/splashScreen/logosplash.png', width: 150),
              const SizedBox(height: 20),
              Text(
                'BetterLife',
                style: TextStyle(
                  fontSize: 50.11,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
