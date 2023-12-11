part of 'main_bloc.dart';

sealed class MainState {}

class MainStateLoading extends MainState {}

class MainStateSuccess extends MainState {
  MainStateSuccess(this.weatherModel, this.weatherHourlyModel, this.time);

  final WeatherModel weatherModel;
  final WeatherHourlyModel weatherHourlyModel;
  final DateTime time;

  String get description {
    final camelLetter = weatherModel.weather.first.description[0].toUpperCase();
    final content = weatherModel.weather.first.description.substring(1);
    return '$camelLetter$content';
  }
}

class MainStateError extends MainState {
  MainStateError(this.error);

  final Object error;
}
