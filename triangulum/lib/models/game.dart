class Game {
  final int id;
  final String name;
  final String? coverUrl;
  final double? rating;

  Game({
    required this.id,
    required this.name,
    this.coverUrl,
    this.rating,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    String? processedCoverUrl = json['cover']?['url'];
    if (processedCoverUrl != null) {
      // Convert relative URL to absolute and get larger image size
      processedCoverUrl = 'https:${processedCoverUrl.replaceAll('thumb', 'cover_big')}';
    }

    return Game(
      id: json['id'],
      name: json['name'],
      coverUrl: processedCoverUrl,
      rating: json['rating']?.toDouble(),
    );
  }
} 