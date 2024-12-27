import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_app_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Future<void> _markLandingAsSeen(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenLanding', true);
    
    if (!context.mounted) return;
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainAppPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 900;
            final isTablet = constraints.maxWidth > 600;
            
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 48 : 24,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.videogame_asset_rounded,
                      size: isDesktop ? 120 : (isTablet ? 100 : 80),
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: isDesktop ? 40 : 30),
                    Text(
                      'Triangulum',
                      style: TextStyle(
                        fontSize: isDesktop ? 48 : (isTablet ? 32 : 24),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isDesktop ? 30 : 20),
                    Text(
                      'Your Gateway to Gaming!',
                      style: TextStyle(
                        fontSize: isDesktop ? 24 : (isTablet ? 18 : 16),
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isDesktop ? 60 : 40),
                    ElevatedButton(
                      onPressed: () => _markLandingAsSeen(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 48 : 32,
                          vertical: isDesktop ? 24 : 16,
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: isDesktop ? 18 : 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 