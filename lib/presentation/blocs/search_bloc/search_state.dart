part of 'search_bloc.dart';

sealed class SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchErrorState extends SearchState {
  SearchErrorState(this.error);

  final Object error;
}

final class SearchSuccessState extends SearchState {
  SearchSuccessState(this.weatherModel);

  final WeatherModel? weatherModel;
}

final class SearchEmptyState extends SearchState {

}
