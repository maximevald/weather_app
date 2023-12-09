import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/domain/language_code.dart';

class LanguageCubit extends Cubit<LanguageCode> {
  LanguageCubit() : super(LanguageCode.ru);

  void change(LanguageCode code) {
    emit(code);
  }
}
