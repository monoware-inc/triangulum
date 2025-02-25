import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            final isDesktop = screenWidth > 900;
            final isTablet = screenWidth > 600;
            
            // Adjusted sizes for better mobile display
            final iconSize = isDesktop ? 100.0 : (isTablet ? 80.0 : 64.0);
            final titleSize = isDesktop ? 40.0 : (isTablet ? 32.0 : 28.0);
            final subtitleSize = isDesktop ? 20.0 : (isTablet ? 18.0 : 16.0);
            final buttonGridWidth = isDesktop ? 300.0 : (isTablet ? 250.0 : 180.0);
            
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.15), // Push content up
                      Column(
                        children: [
                          Icon(
                            Icons.sports_esports,
                            size: iconSize,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'GameTrack',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontSize: titleSize,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Your Gateway to Gaming!',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: subtitleSize,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.25), // More space between text and buttons
                      SizedBox(
                        width: buttonGridWidth,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.0,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildAuthButton(
                              context,
                              const FaIcon(FontAwesomeIcons.google, size: 24),
                              () => _markLandingAsSeen(context),
                            ),
                            _buildAuthButton(
                              context,
                              const FaIcon(FontAwesomeIcons.apple, size: 24),
                              () => _markLandingAsSeen(context),
                            ),
                            _buildAuthButton(
                              context,
                              const FaIcon(FontAwesomeIcons.twitch, size: 24),
                              () => _markLandingAsSeen(context),
                            ),
                            _buildAuthButton(
                              context,
                              const Icon(Icons.email, size: 24),
                              () => _markLandingAsSeen(context),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.15), // Bottom padding
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAuthButton(
    BuildContext context,
    Widget icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        padding: const EdgeInsets.all(10),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Center(child: icon),
    );
  }
} 