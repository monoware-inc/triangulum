import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet = constraints.maxWidth > 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: isDesktop ? 24 : (isTablet ? 20 : 16),
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: isDesktop ? 8 : 4),
            // TODO: Fetch user name from database
            Text(
              'User',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: isDesktop ? 48 : (isTablet ? 36 : 28),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
} 