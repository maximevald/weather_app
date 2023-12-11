import 'package:flutter/material.dart';

import 'package:weather_application/domain/weather_hourly/weather_hourly_model.dart';

import 'package:weather_application/presentation/widgets/hourly_weather_container_item.dart';

class HourlyWeatherContainer extends StatelessWidget {
  const HourlyWeatherContainer({required this.weatherHourlyModel, super.key});
  final WeatherHourlyModel weatherHourlyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.shade100,
      ),
      margin: const EdgeInsets.all(10),
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: weatherHourlyModel.list!.take(6).map((weather) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: HourlyWeatherContainerItem(
              id: weather.weather!.first.icon,
              temperature: '${weather.main!.temp.ceil()}',
              time: weather.dtTxt!,
            ),
          );
        }).toList(),
      ),
    );
  }
}
