import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/domain/language_code.dart';
import 'package:weather_application/presentation/blocs/language/language_cubit.dart';
import 'package:weather_application/presentation/blocs/main_bloc/main_bloc.dart';

class LastWeatherUpdate extends StatelessWidget {
  const LastWeatherUpdate({required this.success, super.key});
  final MainStateSuccess success;

  @override
  Widget build(BuildContext context) {

    final time = success.time;
    
    if (time.second != DateTime.now().second) {
      return Text(
        context.read<LanguageCubit>().state == LanguageCode.ru
            ? time.minute.toString().length == 1
                ? 'Последнее обновление: ${time.hour}:0${time.minute}'
                : 'Последнее обновление: ${time.hour}:${time.minute}'
            : time.minute.toString().length == 1
                ? 'Last update: ${time.hour}:0${time.minute}'
                : 'Last update: ${time.hour}:${time.minute}',
        textAlign: TextAlign.center,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
