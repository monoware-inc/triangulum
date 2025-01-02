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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          final isTablet = constraints.maxWidth > 600;

          return CustomScrollView(
            slivers: [
              // Sliver App Bar with game cover image
              SliverAppBar(
                expandedHeight: isDesktop ? 500 : (isTablet ? 400 : 300),
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: game.coverUrl != null
                      ? Image.network(
                          game.getHighResolutionCoverUrl()!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Theme.of(context).colorScheme.surfaceVariant,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Theme.of(context).colorScheme.surfaceVariant,
                              child: const Center(
                                child: Icon(
                                  Icons.error_outline,
                                  size: 48,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // Game details
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop ? 1200 : double.infinity,
                    ),
                    padding: EdgeInsets.all(
                      isDesktop ? 48 : (isTablet ? 32 : 24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Game title
                        Text(
                          game.name,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontSize: isDesktop ? 48 : (isTablet ? 36 : 28),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Rating section
                        if (game.rating != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 28,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  game.rating!.toStringAsFixed(1),
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '/ 10',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                        // TODO: Add more game details sections here
                        // For example: description, release date, platforms, etc.
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 