import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/cach_data/app_shared_preferences.dart';
import 'providers/authProvider.dart';
import 'providers/pill_reminder_prov.dart';
import 'ui/home/homeScreen.dart';
import 'ui/home/profileScreen/profileScreen.dart';
import 'ui/login_signup/forgotPasswordScreen/creatNewPassword.dart';
import 'ui/login_signup/loginScreen/loginScreen.dart';
import 'ui/login_signup/signupScreen/signupScreen.dart';
import 'ui/login_signup/forgotPasswordScreen/verificationScreen.dart';
import 'ui/welcome_pages/onboardingScreen/onboardingScreen.dart';
import 'ui/welcome_pages/splashScreen/splashScreen.dart';
import 'ChatBot/ChatScreenBot.dart';
import 'Notifications/NotificationService.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xFF199A8E),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF199A8E),
    primary: const Color(0xFF199A8E),
    secondary: const Color(0xFF199A8E),
    background: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    labelMedium: TextStyle(color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Color(0xFF199A8E)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF199A8E),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(const Color(0xFF199A8E)),
  ),
  useMaterial3: true,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await AppPreferences().init();

  final authProvider = AuthProvider();
  await authProvider.loadToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PillReminderProvider()),
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BetterLife',
      theme: appTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        SignUpScreen.routeName: (_) => SignUpScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        VerificationScreen.routName: (_) => VerificationScreen(userInput: ''),
        CreateNewPasswordScreen.routeName: (_) => CreateNewPasswordScreen(),
        ProfileScreen.routeName: (_) => const ProfileScreen(),
        ChatScreenBot.routeName: (_) => ChatScreenBot(),
      },
      initialRoute:
      auth.token != null ? HomeScreen.routeName : SplashScreen.routeName,
    );
  }
}
