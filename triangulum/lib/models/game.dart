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

  String? getHighResolutionCoverUrl() {
    if (coverUrl == null) return null;
    // Convert to high-resolution version
    return coverUrl!.replaceAll('thumb', 'cover_big');
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    String? processedCoverUrl = json['cover']?['url'];
    if (processedCoverUrl != null) {
      // Ensure URL starts with https:
      if (!processedCoverUrl.startsWith('https:')) {
        processedCoverUrl = 'https:$processedCoverUrl';
      }
    }

    return Game(
      id: json['id'],
      name: json['name'],
      coverUrl: processedCoverUrl,
      rating: json['rating']?.toDouble(),
    );
  }
}

enum ImageSize {
  thumb('thumb'),
  cover_small('cover_small'),
  cover_big('cover_big'),
  screenshot_med('screenshot_med'),
  screenshot_big('screenshot_big'),
  screenshot_huge('screenshot_huge'),
  logo_med('logo_med'),
  hd('720p'),
  fullHd('1080p');

  final String value;
  const ImageSize(this.value);
} 