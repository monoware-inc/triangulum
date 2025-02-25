class Game {
  final int id;
  final String name;
  final String? coverUrl;
  final String? summary;

  Game({
    required this.id,
    required this.name,
    this.coverUrl,
    this.summary,
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
      summary: json['summary'],
    );
  }
}

enum ImageSize {
  thumb('thumb'),
  coverSmall('cover_small'),
  coverBig('cover_big'),
  screenshotMed('screenshot_med'),
  screenshotBig('screenshot_big'),
  screenshotHuge('screenshot_huge'),
  logoMed('logo_med'),
  hd('720p'),
  fullHd('1080p');

  final String value;
  const ImageSize(this.value);
} 