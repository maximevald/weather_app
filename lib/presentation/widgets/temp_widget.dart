import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/domain/language_code.dart';
import 'package:weather_application/presentation/blocs/language/language_cubit.dart';

class TempWidget extends StatelessWidget {
  const TempWidget({required this.temp, super.key});
  final String temp;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageCode>(
      builder: (context, code) {
        final degre = switch (code) {
          LanguageCode.ru => '°C',
          LanguageCode.en => '℉',
        };
        return Text('$temp$degre');
      },
    );
  }
}
