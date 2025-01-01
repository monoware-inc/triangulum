import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/igdb_service.dart';

class NewReleasesWidget extends StatefulWidget {
  const NewReleasesWidget({super.key});

  @override
  State<NewReleasesWidget> createState() => _NewReleasesWidgetState();
}

class _NewReleasesWidgetState extends State<NewReleasesWidget> {
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
      final games = await _igdbService.getNewReleases();
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
                'New Releases',
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
                            return Container(
                              width: cardWidth,
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
                                        game.coverUrl!,
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