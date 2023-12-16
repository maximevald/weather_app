import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/domain/language_code.dart';

class LanguageCubit extends Cubit<LanguageCode> {
  LanguageCubit(this.prefs) : super(LanguageCode.ru);

  final SharedPreferences prefs;

  Future<void> change(LanguageCode code) async{
    emit(code);
    await prefs.setString('language', code.name);
  }

  Future<void> loadLanguage() async {
    final loadedLanguage = prefs.getString('language');
    if(loadedLanguage == null) {
      return;
    }
    emit(LanguageCode.values.byName(loadedLanguage));
  }
}
