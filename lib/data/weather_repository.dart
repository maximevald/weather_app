import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/domain/language_code.dart';
import 'package:weather_application/domain/weather_current/coord.dart';
import 'package:weather_application/domain/weather_current/weather_model.dart';
import 'package:weather_application/domain/weather_hourly/weather_hourly_model.dart';

class WeatherRepository {
  WeatherRepository(this.prefs, this.code);

  static const weatherRepository = 'api.openweathermap.org';
  static const pathCurrent = '/data/2.5/weather';
  static const pathHourly = '/data/2.5/forecast/';
  static const apiKey = String.fromEnvironment('apiKey');

  final SharedPreferences prefs;
  final LanguageCode code;

  Future<WeatherModel> getWeatherByCoordinates(Coord coord) async {
    final url = Uri.https(
      weatherRepository,
      pathCurrent,
      {
        'lat': coord.lat.toString(),
        'lon': coord.lon.toString(),
        'appid': apiKey,
        'lang': code.name,
        'units': code.units,
      },
    );

    final response = await http.get(url);
    return weatherModelFromJson(response.body);
  }

  Future<WeatherModel> getWeatherByCitySearch(String city) async {
    final url = Uri.https(
      weatherRepository,
      pathCurrent,
      {
        'q': city,
        'appid': apiKey,
        'lang': code.name,
        'units': code.units,
      },
    );

    final response = await http.get(url);
    return weatherModelFromJson(response.body);
  }

  Future<WeatherHourlyModel> getWeatherByCoordinatesHourly(Coord coord) async {
    final url = Uri.https(
      weatherRepository,
      pathHourly,
      {
        'lat': coord.lat.toString(),
        'lon': coord.lon.toString(),
        'appid': apiKey,
        'lang': code.name,
        'units': code.units,
      },
    );

    final response = await http.get(url);
    return weatherHourlyModelFromJson(response.body);
  }

  Future<(WeatherModel, WeatherHourlyModel)> getWeather(Coord coord) async {
    final weatherByCoord = await getWeatherByCoordinates(coord);
    final weatherByCoordHourly = await getWeatherByCoordinatesHourly(coord);
    final time = DateTime.now();
    await prefs.setString('time', time.toIso8601String());
    await prefs.setString('current', weatherModelToJson(weatherByCoord));
    await prefs.setString(
      'hourly',
      weatherHourlyModelToJson(weatherByCoordHourly),
    );
    return (weatherByCoord, weatherByCoordHourly);
  }

  Future<(DateTime, WeatherModel, WeatherHourlyModel)?>
      getCachedWeather() async {
    final timeString = prefs.getString('time');

    if (timeString != null) {
      final weatherByCoord = weatherModelFromJson(prefs.getString('current')!);
      final weatherByCoordHourly =
          weatherHourlyModelFromJson(prefs.getString('hourly')!);
      final time = DateTime.parse(timeString);
      return (time, weatherByCoord, weatherByCoordHourly);
    }
    return null;
  }
}
