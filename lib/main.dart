import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/data/weather_repository.dart';
import 'package:weather_application/domain/language_code.dart';
import 'package:weather_application/presentation/blocs/language/language_cubit.dart';
import 'package:weather_application/presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  runApp(
    MyApp(
      prefs: prefs,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.prefs, super.key});
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, LanguageCode>(
        builder: (context, code) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                key: ValueKey(code),
                create: (context) => WeatherRepository(prefs, code),
              ),
              RepositoryProvider(
                create: (context) => Location(),
              ),
              RepositoryProvider(
                create: (context) => Connectivity(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Weather',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                useMaterial3: true,
              ),
              home: const MainScreen(),
            ),
          );
        },
      ),
    );
  }
}
