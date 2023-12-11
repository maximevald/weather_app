class Coord {
  const Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json['lon']?.toDouble(),
        lat: json['lat']?.toDouble(),
      );

  final double? lon;
  final double? lat;

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}
