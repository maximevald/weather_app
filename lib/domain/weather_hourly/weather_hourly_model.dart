// To parse this JSON data, do
//
//     final weatherHourlyModel = weatherHourlyModelFromJson(jsonString);

import 'dart:convert';

import 'package:weather_application/domain/weather_hourly/city.dart';
import 'package:weather_application/domain/weather_hourly/weather_by_date.dart';

WeatherHourlyModel weatherHourlyModelFromJson(String str) =>
    WeatherHourlyModel.fromJson(json.decode(str));

String weatherHourlyModelToJson(WeatherHourlyModel data) =>
    json.encode(data.toJson());

class WeatherHourlyModel {
  WeatherHourlyModel({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory WeatherHourlyModel.fromJson(Map<String, dynamic> json) =>
      WeatherHourlyModel(
        cod: json['cod']?.toString(),
        message: json['message']?.toString(),
        cnt: json['cnt'],
        list: json['list'] == null
            ? []
            : List<WeatherByDate>.from(
                json['list']!.map(
                  (x) => WeatherByDate.fromJson(x),
                ),
              ),
        city: json['city'] == null ? null : City.fromJson(json['city']),
      );
  final String? cod;
  final String? message;
  final int? cnt;
  final List<WeatherByDate>? list;
  final City? city;

  Map<String, dynamic> toJson() => {
        'cod': cod,
        'message': message,
        'cnt': cnt,
        'list': list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        'city': city?.toJson(),
      };
}
