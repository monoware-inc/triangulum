import 'package:flutter/material.dart';
import '../models/game.dart';
import '../pages/game_details_page.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final double width;
  final double imageHeight;
  final double titleSize;

  const GameCard({
    super.key,
    required this.game,
    required this.width,
    required this.imageHeight,
    required this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailsPage(game: game),
          ),
        );
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (game.coverUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  game.getHighResolutionCoverUrl()!,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      height: imageHeight,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                game.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: titleSize,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 