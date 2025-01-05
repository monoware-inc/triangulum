import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/game_details/game_cover_header_widget.dart';
import '../widgets/game_details/game_name_header_widget.dart';
import '../widgets/game_details/game_summary_widget.dart';

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
              GameCoverHeader(
                game: game,
                expandedHeight: isDesktop ? 500 : (isTablet ? 400 : 300),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: isDesktop ? 48 : (isTablet ? 32 : 24),
                    right: isDesktop ? 48 : (isTablet ? 32 : 24),
                    top: isDesktop ? 48 : (isTablet ? 32 : 24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GameNameHeader(name: game.name),
                      const SizedBox(height: 32),
                      if (game.summary != null)
                        GameSummary(summary: game.summary!),
                    ],
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