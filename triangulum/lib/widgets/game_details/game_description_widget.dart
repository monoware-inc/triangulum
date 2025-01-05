import 'package:flutter/material.dart';

class GameDescription extends StatelessWidget {
  final String description;

  const GameDescription({
    super.key,
    required this.description,
  });

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
              'Description',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isDesktop ? 24 : (isTablet ? 22 : 20),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                height: 1.5,
              ),
            ),
          ],
        );
      },
    );
  }
} 