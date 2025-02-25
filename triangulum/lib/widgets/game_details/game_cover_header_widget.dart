import 'package:flutter/material.dart';
import 'dart:ui';
import '../../models/game.dart';

class GameCoverHeader extends StatelessWidget {
  final Game game;
  final double expandedHeight;

  const GameCoverHeader({
    super.key,
    required this.game,
    required this.expandedHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background with blur
            Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
                ),
              ),
            ),
            // Centered game cover
            Center(
              child: Container(
                height: expandedHeight * 0.8,
                width: expandedHeight * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: game.coverUrl != null
                      ? Image.network(
                          game.getHighResolutionCoverUrl()!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              child: Center(
                                child: Icon(
                                  Icons.error_outline,
                                  size: 48,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
} 