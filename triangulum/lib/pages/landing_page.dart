import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth_service.dart';
import '../widgets/auth/email_auth_dialog.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthService _authService = AuthService();
  final Map<String, bool> _loadingStates = {
    'google': false,
    'apple': false,
    'twitch': false,
    'email': false,
  };

  void _setLoading(String provider, bool isLoading) {
    setState(() {
      _loadingStates[provider] = isLoading;
    });
  }

  void _handleAuthError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    _setLoading('google', true);
    final (_, error) = await _authService.signInWithGoogle();
    
    if (!context.mounted) return;
    _setLoading('google', false);

    if (error != null) {
      _handleAuthError(context, error);
    }
    // AuthState handles navigation automatically
  }

  Future<void> _handleAppleSignIn(BuildContext context) async {
    _setLoading('apple', true);
    final (_, error) = await _authService.signInWithApple();
    
    if (!context.mounted) return;
    _setLoading('apple', false);

    if (error != null) {
      _handleAuthError(context, error);
    }
  }

  Future<void> _handleTwitchSignIn(BuildContext context) async {
    _setLoading('twitch', true);
    // TODO: Implement Twitch auth
    _setLoading('twitch', false);
    
    if (!context.mounted) return;
    _handleAuthError(context, 'Twitch sign-in not implemented yet');
  }

  Future<void> _handleEmailAuth(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => EmailAuthDialog(
        title: 'Sign In',
        submitButtonText: 'Sign In',
        onSubmit: (email, password) async {
          final (_, error) = await _authService.signInWithEmail(email, password);
          
          if (!context.mounted) return;
          Navigator.pop(context); // Close dialog

          if (error != null) {
            _handleAuthError(context, error);
            if (error.contains('user-not-found')) {
              _showSignUpDialog(context, email, password);
            }
          }
          // AuthState handles navigation
        },
      ),
    );
  }

  void _showSignUpDialog(BuildContext context, String email, String password) {
    showDialog(
      context: context,
      builder: (context) => EmailAuthDialog(
        title: 'Create Account',
        submitButtonText: 'Sign Up',
        onSubmit: (email, password) async {
          final (_, error) = await _authService.signUpWithEmail(email, password);
          
          if (!context.mounted) return;
          Navigator.pop(context);

          if (error != null) {
            _handleAuthError(context, error);
          }
          // AuthState handles navigation
        },
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
                              () => _handleGoogleSignIn(context),
                              'google',
                            ),
                            _buildAuthButton(
                              context,
                              const FaIcon(FontAwesomeIcons.apple, size: 24),
                              () => _handleAppleSignIn(context),
                              'apple',
                            ),
                            _buildAuthButton(
                              context,
                              const FaIcon(FontAwesomeIcons.twitch, size: 24),
                              () => _handleTwitchSignIn(context),
                              'twitch',
                            ),
                            _buildAuthButton(
                              context,
                              const Icon(Icons.email, size: 24),
                              () => _handleEmailAuth(context),
                              'email',
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
    String provider,
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
      child: Center(
        child: icon,
      ),
    );
  }
} 