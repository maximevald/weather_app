import 'package:flutter/material.dart';
import 'package:weather_application/presentation/widgets/temp_widget.dart';
import 'package:weather_application/presentation/widgets/weather_icon.dart';

class HourlyWeatherContainerItem extends StatelessWidget {
  const HourlyWeatherContainerItem({
    required this.temperature,
    required this.time,
    required this.id,
    super.key,
  });

  final String temperature;
  final DateTime time;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${time.hour}:${time.minute}0'),
          WeatherIcon(
            id: id,
            scale: 2,
            size: 35,
          ),
          TempWidget(temp: temperature),
        ],
      ),
    );
  }
}
