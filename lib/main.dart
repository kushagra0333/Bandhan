import 'package:flutter/material.dart';
import './pages/login.dart';
import './pages/signup.dart';
import './pages/dashboard.dart';
import './pages/home.dart';
import './pages/likes.dart';

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
        '/': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/likes': (context) => const LikesPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
