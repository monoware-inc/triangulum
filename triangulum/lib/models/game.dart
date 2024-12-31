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
    return Game(
      id: json['id'],
      name: json['name'],
      coverUrl: json['cover']?['url'],
      rating: json['rating']?.toDouble(),
    );
  }
} 