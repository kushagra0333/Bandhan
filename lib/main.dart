import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/login.dart';
import './pages/signup.dart';
import './pages/dashboard.dart';
import './pages/home.dart';
import './pages/likes.dart';
import './pages/welcome.dart';
import './pages/personal_detail.dart';
import './pages/family_page.dart';
import './pages/see_member.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Dashboard',
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (contect) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/likes': (context) => const LikesPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/edit-details' : (context) => const PersonalDetailApp(),
        '/add-member' :(context) => const FamilyDetailsScreen(),
        '/see-member' :(context) => const SeeFamilyScreen(),
      },
    );
  }
}
