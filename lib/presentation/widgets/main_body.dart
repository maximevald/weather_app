import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/domain/language_code.dart';
import 'package:weather_application/domain/weather_current/weather_model.dart';
import 'package:weather_application/presentation/blocs/language/language_cubit.dart';

import 'package:weather_application/presentation/blocs/main_bloc/main_bloc.dart';
import 'package:weather_application/presentation/screens/search_screen.dart';
import 'package:weather_application/presentation/widgets/daily_weather_container.dart';
import 'package:weather_application/presentation/widgets/hourly_weather_container.dart';
import 'package:weather_application/presentation/widgets/last_weather_update.dart';
import 'package:weather_application/presentation/widgets/temp_widget.dart';

import 'package:weather_application/presentation/widgets/weather_icon.dart';

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    
    final languageCubit = context.read<LanguageCubit>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _search(context),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => _changeLocation(languageCubit),
            icon: Text(languageCubit.state.name.toUpperCase()),
          ),
        ],
      ),
      body: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return switch (state) {
            MainStateLoading _ => const Center(
                child: CircularProgressIndicator(),
              ),
            MainStateError(:final error) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
            final MainStateSuccess success => Center(
                child: ListView(
                  children: [
                    LastWeatherUpdate(success: success),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TempWidget(
                          temp:
                              success.weatherModel.main.temp.ceil().toString(),
                          size: 50,
                        ),
                        WeatherIcon(
                          id: success.weatherModel.weather.first.icon,
                        ),
                      ],
                    ),
                    Text(
                      success.weatherModel.name,
                      style: const TextStyle(fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      success.description,
                      style: const TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    HourlyWeatherContainer(
                      weatherHourlyModel: success.weatherHourlyModel,
                    ),
                    const SizedBox(height: 40),
                    DailyWeatherContainer(
                      weatherDailyModel: success.weatherHourlyModel,
                    ),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }

  Future<void> _search(BuildContext context) async {
    final cubit = context.read<MainCubit>();
    final weatherParams = await Navigator.of(context).push<WeatherModel>(
      MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      ),
    );
    if (weatherParams != null) {
      await cubit.setWeatherParams(weatherParams);
    }
  }

  void _changeLocation(LanguageCubit languageCubit) {
    languageCubit.change(
      LanguageCode.values
          .firstWhere((element) => languageCubit.state != element),
    );
  }
}
