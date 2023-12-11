import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/domain/language_code.dart';
import 'package:weather_application/domain/localization.dart';
import 'package:weather_application/presentation/blocs/language/language_cubit.dart';
import 'package:weather_application/presentation/widgets/temp_widget.dart';
import 'package:weather_application/presentation/widgets/weather_icon.dart';

class DailyWeatherContainerItem extends StatelessWidget {
  const DailyWeatherContainerItem({
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

    final languageState = context.read<LanguageCubit>().state;
    final dayFormat = DateFormat('EEEE').format(time);
    final monthFormat = DateFormat('MMMM').format(time);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '${languageState == LanguageCode.ru ? days[dayFormat] : dayFormat}',
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${time.day} ${languageState == LanguageCode.ru ? months[monthFormat] : monthFormat}',
          ),
        ),
        Expanded(
          child: WeatherIcon(
            id: id,
            scale: 2,
            size: 35,
          ),
        ),
        Expanded(child: TempWidget(temp: temperature)),
      ],
    );
  }
}
