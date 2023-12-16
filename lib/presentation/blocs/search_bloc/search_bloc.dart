import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_application/data/weather_repository.dart';
import 'package:weather_application/domain/weather_current/weather_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._weatherRepository) : super(SearchEmptyState()) {
    on<SearchTextEvent>(
      _search,
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(seconds: 1)).switchMap(mapper),
    );
  }

  final WeatherRepository _weatherRepository;

  Future<void> _search(SearchTextEvent event, Emitter<SearchState> emit) async {
    if (event.text.isEmpty) {
      emit(SearchEmptyState());
    } else {
      try {
        final weatherByCity =
            await _weatherRepository.getWeatherByCitySearch(event.text);
        emit(SearchSuccessState(weatherByCity));
      } catch (e) {
        emit(SearchSuccessState(null));
      }
    }
  }
}
