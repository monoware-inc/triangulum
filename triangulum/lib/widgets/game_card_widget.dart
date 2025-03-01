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
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.network(
                  (game.coverUrl != null) 
                      ? game.coverUrl!.replaceAll('t_thumb', 't_cover_big')
                      : 'https://placeholder.com/no-image',
                  width: width,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: width,
                      height: imageHeight,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Icon(
                        Icons.error_outline,
                        size: 32.0,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  game.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: titleSize,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 