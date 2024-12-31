import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/igdb_service.dart';

class TrendingGamesWidget extends StatefulWidget {
  const TrendingGamesWidget({super.key});

  @override
  State<TrendingGamesWidget> createState() => _TrendingGamesWidgetState();
}

class _TrendingGamesWidgetState extends State<TrendingGamesWidget> {
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
      final games = await _igdbService.getTrendingGames();
      setState(() {
        _games = games;
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      print('Error in widget: $e');
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(child: Text('Error: $_error'))
                  : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _games.length,
                  itemBuilder: (context, index) {
                    final game = _games[index];
                    return Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
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
                                game.coverUrl!,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              game.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
} 