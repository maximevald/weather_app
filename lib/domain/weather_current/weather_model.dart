// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

import 'package:weather_application/domain/weather_current/clouds.dart';
import 'package:weather_application/domain/weather_current/coord.dart';
import 'package:weather_application/domain/weather_current/country_params.dart';
import 'package:weather_application/domain/weather_current/geo_position_params.dart';
import 'package:weather_application/domain/weather_current/rain.dart';
import 'package:weather_application/domain/weather_current/weather.dart';
import 'package:weather_application/domain/weather_current/wind.dart';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str) as Map<String, dynamic>);

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  const WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.rain,
    required this.clouds,
    required this.dt,
    required this.countryParams,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        coord: json['coord'] == null ? null : Coord.fromJson(json['coord']),
        weather: List<Weather>.from(
          json['weather'].map((x) => Weather.fromJson(x)),
        ),
        base: json['base'],
        main: GeoPositionParams.fromJson(json['main']),
        visibility: json['visibility'],
        wind: Wind.fromJson(json['wind']),
        rain: json['rain'] == null ? null : Rain.fromJson(json['rain']),
        clouds: Clouds.fromJson(json['clouds']),
        dt: json['dt'],
        countryParams:
            json['sys'] == null ? null : CountryParams.fromJson(json['sys']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod'],
      );

  final Coord? coord;
  final List<Weather> weather;
  final String base;
  final GeoPositionParams main;
  final int visibility;
  final Wind wind;
  final Rain? rain;
  final Clouds clouds;
  final int dt;
  final CountryParams? countryParams;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
        'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
        'base': base,
        'main': main.toJson(),
        'visibility': visibility,
        'wind': wind.toJson(),
        'rain': rain?.toJson(),
        'clouds': clouds.toJson(),
        'dt': dt,
        'sys': countryParams?.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
      };
}
