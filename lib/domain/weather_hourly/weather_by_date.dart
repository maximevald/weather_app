// To parse this JSON data, do
//
//     final weatherHourlyModel = weatherHourlyModelFromJson(jsonString);

import 'package:weather_application/domain/weather_current/clouds.dart';
import 'package:weather_application/domain/weather_current/country_params.dart';
import 'package:weather_application/domain/weather_current/geo_position_params.dart';
import 'package:weather_application/domain/weather_current/rain.dart';
import 'package:weather_application/domain/weather_current/weather.dart';
import 'package:weather_application/domain/weather_current/wind.dart';

class WeatherByDate {
  WeatherByDate({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.snow,
    this.sys,
    this.dtTxt,
    this.rain,
  });

  factory WeatherByDate.fromJson(Map<String, dynamic> json) => WeatherByDate(
        dt: json['dt'],
        main: json['main'] == null
            ? null
            : GeoPositionParams.fromJson(json['main']),
        weather: json['weather'] == null
            ? []
            : List<Weather>.from(
                json['weather']!.map((x) => Weather.fromJson(x)),
              ),
        clouds: json['clouds'] == null ? null : Clouds.fromJson(json['clouds']),
        wind: json['wind'] == null ? null : Wind.fromJson(json['wind']),
        visibility: json['visibility'],
        pop: json['pop']?.toDouble(),
        snow: json['snow'] == null ? null : Rain.fromJson(json['snow']),
        sys: json['sys'] == null ? null : CountryParams.fromJson(json['sys']),
        dtTxt: json['dt_txt'] == null ? null : DateTime.parse(json['dt_txt']),
        rain: json['rain'] == null ? null : Rain.fromJson(json['rain']),
      );
  final int? dt;
  final GeoPositionParams? main;
  final List<Weather>? weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Rain? snow;
  final CountryParams? sys;
  final DateTime? dtTxt;
  final Rain? rain;

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'main': main?.toJson(),
        'weather': weather == null
            ? []
            : List<dynamic>.from(weather!.map((x) => x.toJson())),
        'clouds': clouds?.toJson(),
        'wind': wind?.toJson(),
        'visibility': visibility,
        'pop': pop,
        'snow': snow?.toJson(),
        'sys': sys?.toJson(),
        'dt_txt': dtTxt?.toIso8601String(),
        'rain': rain?.toJson(),
      };
}
