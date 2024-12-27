import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/landing_page.dart';
import 'pages/main_app_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Triangulum',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const InitialPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool _initialized = false;
  bool _showLanding = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenLanding = prefs.getBool('hasSeenLanding') ?? false;

    setState(() {
      _showLanding = !hasSeenLanding;
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return _showLanding ? const LandingPage() : const MainAppPage();
  }
}
