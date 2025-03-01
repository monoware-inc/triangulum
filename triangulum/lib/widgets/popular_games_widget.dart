import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/igdb_service.dart';
import 'game_card_widget.dart';

class PopularGamesWidget extends StatefulWidget {
  const PopularGamesWidget({super.key});

  @override
  State<PopularGamesWidget> createState() => _PopularGamesWidgetState();
}

class _PopularGamesWidgetState extends State<PopularGamesWidget> {
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
      final games = await _igdbService.getPopularGames();
      if (!mounted) return;
      setState(() {
        _games = games;
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
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
        final cardWidth = isDesktop ? 400.0 : (isTablet ? 320.0 : 280.0);
        final imageHeight = isDesktop ? 480.0 : (isTablet ? 400.0 : 320.0);
        final titleSize = isDesktop ? 20.0 : (isTablet ? 18.0 : 16.0);

        return SizedBox(
          height: imageHeight + 60,
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : _error != null
                  ? Center(
                      child: Text(
                        'Error: $_error',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    )
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
        );
      },
    );
  }
} 