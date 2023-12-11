import 'package:flutter/material.dart';

import 'package:weather_application/domain/weather_hourly/weather_hourly_model.dart';
import 'package:weather_application/presentation/widgets/daily_weather_container_item.dart';

class DailyWeatherContainer extends StatelessWidget {
  const DailyWeatherContainer({required this.weatherDailyModel, super.key});
  final WeatherHourlyModel weatherDailyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade100,
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < weatherDailyModel.list!.length; i = i + 8)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: DailyWeatherContainerItem(
                id: weatherDailyModel.list![i].weather!.first.icon,
                temperature: '${weatherDailyModel.list![i].main!.temp.ceil()}',
                time: weatherDailyModel.list![i].dtTxt!,
              ),
            ),
        ],
      ),
    );
  }
}
