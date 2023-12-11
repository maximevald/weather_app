import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_application/data/weather_repository.dart';

import 'package:weather_application/domain/weather_current/coord.dart';
import 'package:weather_application/domain/weather_current/weather_model.dart';
import 'package:weather_application/domain/weather_hourly/weather_hourly_model.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this._weatherRepository, this._location, this._connectivity)
      : super(MainStateLoading());

  final WeatherRepository _weatherRepository;
  final Location _location;
  final Connectivity _connectivity;

  Future<void> init() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      final cached = await _weatherRepository.getCachedWeather();
      if (cached != null) {
        emit(MainStateSuccess(cached.$2, cached.$3, cached.$1));
      } else {
        emit(MainStateError(Exception()));
      }
    } else {
      try {
        final coord = await _getCurrentLocation().timeout(
              const Duration(seconds: 7),
              onTimeout: () => null,
            ) ??
            const Coord(lat: 53.89, lon: 27.56);

        final (weatherByCoord, weatherByCoordHourly) =
            await _weatherRepository.getWeather(coord);
        emit(
          MainStateSuccess(
            weatherByCoord,
            weatherByCoordHourly,
            DateTime.now(),
          ),
        );
      } catch (e) {
        emit(MainStateError(e));
      }
    }
  }

  Future<Coord?> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await _location.getLocation();

    final lat = locationData.latitude;
    final lon = locationData.longitude;

    return Coord(lon: lon, lat: lat);
  }

  Future<void> setWeatherParams(WeatherModel model) async {
    emit(MainStateLoading());
    try {
      final weatherByCoordHourly =
          await _weatherRepository.getWeatherByCoordinatesHourly(model.coord!);
      emit(
        MainStateSuccess(
          model,
          weatherByCoordHourly,
          DateTime.now(),
        ),
      );
    } catch (e) {
      emit(MainStateError(e));
    }
  }
}
