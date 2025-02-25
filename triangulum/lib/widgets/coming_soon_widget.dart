import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/igdb_service.dart';
import 'game_card_widget.dart';

class ComingSoonWidget extends StatefulWidget {
  const ComingSoonWidget({super.key});

  @override
  State<ComingSoonWidget> createState() => _ComingSoonWidgetState();
}

class _ComingSoonWidgetState extends State<ComingSoonWidget> {
  final _igdbService = IGDBService();
  List<Game> _games = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    try {
      final games = await _igdbService.getUpcomingGames();
      setState(() {
        _games = games;
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet = constraints.maxWidth > 600;
        final cardWidth = isDesktop ? 200.0 : (isTablet ? 160.0 : 140.0);
        final imageHeight = isDesktop ? 240.0 : (isTablet ? 200.0 : 160.0);
        final titleSize = isDesktop ? 16.0 : (isTablet ? 14.0 : 12.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 24.0 : 16.0,
              ),
              child: Text(
                'Coming Soon',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isDesktop ? 32.0 : (isTablet ? 28.0 : 24.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: imageHeight + 60,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? Center(child: Text('Error: $_error'))
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 24.0 : 16.0,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: _games.length,
                          itemBuilder: (context, index) {
                            final game = _games[index];
                            return GameCard(
                              game: game,
                              width: cardWidth,
                              imageHeight: imageHeight,
                              titleSize: titleSize,
                            );
                          },
                        ),
            ),
          ],
        );
      },
    );
  }
} 