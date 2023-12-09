class Wind {
  const Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json['speed']?.toDouble(),
        deg: json['deg'],
        gust: json['gust']?.toDouble(),
      );

  final double speed;
  final int deg;
  final double gust;

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
        'gust': gust,
      };
}
