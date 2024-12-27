import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back,',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        // TODO: Fetch user name from database
        Text(
          'user',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
} 