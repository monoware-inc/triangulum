import 'package:flutter/material.dart';

class GameSummary extends StatelessWidget {
  final String summary;

  const GameSummary({
    super.key,
    required this.summary,
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
              'Summary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isDesktop ? 24 : (isTablet ? 22 : 20),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              summary,
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