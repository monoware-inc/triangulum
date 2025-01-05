class Game {
  final int id;
  final String name;
  final String? coverUrl;
  final String? description;

  Game({
    required this.id,
    required this.name,
    this.coverUrl,
    this.description,
  });

  String? getHighResolutionCoverUrl() {
    if (coverUrl == null) return null;
    // Convert to high-resolution version
    return coverUrl!.replaceAll('thumb', 'cover_big');
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      coverUrl: json['cover']?['url'] != null 
          ? 'https:${json['cover']['url']}' 
          : null,
      description: json['summary'],
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