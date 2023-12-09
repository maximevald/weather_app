class CountryParams {
  const CountryParams({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory CountryParams.fromJson(Map<String, dynamic> json) => CountryParams(
        type: json['type'],
        id: json['id'],
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );

  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}
