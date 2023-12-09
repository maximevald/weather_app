import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_application/data/weather_repository.dart';
import 'package:weather_application/presentation/blocs/main_bloc/main_bloc.dart';
import 'package:weather_application/presentation/widgets/main_body.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(
        context.read<WeatherRepository>(),
        context.read<Location>(),
        context.read<Connectivity>(),
      )..init(),
      child: const MainBody(),
    );
  }
}
