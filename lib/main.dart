import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/core/services/auth_service.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/providers/authProvider.dart';
import 'package:better_life/ui/logic/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:better_life/l10n/app_localizations.dart'; // لازم تكون مشغل intl

import 'package:better_life/providers/pill_reminder_prov.dart';
import 'package:better_life/ui/home/homeScreen.dart';
import 'package:better_life/ui/home/profileScreen/profileScreen.dart';
import 'package:better_life/ui/home/profileScreen/saved_blogs_screen.dart';
import 'package:better_life/ui/login_signup/forgotPasswordScreen/creatNewPassword.dart';
import 'package:better_life/ui/login_signup/loginScreen/loginScreen.dart';
import 'package:better_life/ui/login_signup/signupScreen/signupScreen.dart';
import 'package:better_life/ui/login_signup/forgotPasswordScreen/verificationScreen.dart';
import 'package:better_life/ui/welcome_pages/onboardingScreen/onboardingScreen.dart';
import 'package:better_life/ui/welcome_pages/splashScreen/splashScreen.dart';
import 'package:better_life/ChatBot/ChatScreenBot.dart';
import 'package:better_life/ui/debug/api_test_screen.dart';
import 'package:better_life/ui/home/notifications/notifications_screen.dart';
import 'package:better_life/ui/home/medical_records/medical_records_screen.dart';
import 'Notifications/NotificationService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_life/ui/logic/notifications/notifications_cubit.dart';
import 'package:better_life/ui/logic/medical_records/medical_records_cubit.dart';

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
  iconTheme: const IconThemeData(
    color: Color(0xFF199A8E),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF199A8E),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(const Color(0xFF199A8E)),
  ),
  useMaterial3: true,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await AppPreferences().init();
  await NotificationService.initialize();
  
  // Check if user is already authenticated
  final authService = AuthService();
  final isLoggedIn = await authService.isLoggedIn();
  
  print('🔍 User authentication status: ${isLoggedIn ? 'Logged In' : 'Not Logged In'}');
  
  if (isLoggedIn) {
    final user = await authService.getCurrentUser();
    print('🔍 Current user: ${user?.displayName}, token: ${user?.token != null ? 'Valid' : 'Invalid'}');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PillReminderProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        BlocProvider(create: (_) => AuthCubit()..checkAuthStatus()),
        BlocProvider(create: (_) => NotificationsCubit()),
        BlocProvider(create: (_) => MedicalRecordsCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  
  @override
  void initState() {
    super.initState();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Determine initial route based on auth state
        String initialRoute = SplashScreen.routeName;
        
        if (state is AuthSuccess) {
          initialRoute = HomeScreen.routeName;
          print('🔍 User authenticated, redirecting to Home');
        } else {
          print('🔍 User not authenticated, redirecting to Splash');
        }
        
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BetterLife',
          theme: appTheme,
          locale: _locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routes: {
            SplashScreen.routeName: (_) => SplashScreen(),
            OnboardingScreen.routeName: (_) => OnboardingScreen(),
            SignUpScreen.routeName: (_) => SignUpScreen(),
            LoginScreen.routeName: (_) => LoginScreen(),
            HomeScreen.routeName: (_) => const HomeScreen(),
            VerificationScreen.routName: (_) => VerificationScreen(userInput: ''),
            CreateNewPasswordScreen.routeName: (_) => CreateNewPasswordScreen(),
            ProfileScreen.routeName: (_) => const ProfileScreen(),
            ChatScreenBot.routeName: (_) => ChatScreenBot(),
            SavedBlogsScreen.routeName: (_) => const SavedBlogsScreen(),
            '/api-test': (_) => const ApiTestScreen(),
            NotificationsScreen.routeName: (_) => const NotificationsScreen(),
            MedicalRecordsScreen.routeName: (_) => const MedicalRecordsScreen(),
          },
          initialRoute: initialRoute,
        );
      },
    );
  }
}
