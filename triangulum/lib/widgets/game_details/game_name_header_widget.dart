import 'package:flutter/material.dart';

class GameNameHeader extends StatelessWidget {
  final String name;

  const GameNameHeader({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet = constraints.maxWidth > 600;

        return Text(
          name,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: isDesktop ? 48 : (isTablet ? 36 : 28),
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
} 