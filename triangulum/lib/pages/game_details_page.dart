import 'package:flutter/material.dart';
import '../models/game.dart';

class GameDetailsPage extends StatelessWidget {
  final Game game;

  const GameDetailsPage({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          final isTablet = constraints.maxWidth > 600;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (game.coverUrl != null)
                  SizedBox(
                    width: double.infinity,
                    height: isDesktop ? 500 : (isTablet ? 400 : 300),
                    child: Image.network(
                      game.coverUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(isDesktop ? 32 : (isTablet ? 24 : 16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.name,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (game.rating != null)
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 8),
                            Text(
                              game.rating!.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      // TODO: Add more game details as needed
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 