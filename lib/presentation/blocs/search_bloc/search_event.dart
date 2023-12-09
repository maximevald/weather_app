part of 'search_bloc.dart';

sealed class SearchEvent {}

class SearchTextEvent extends SearchEvent {
  SearchTextEvent(this.text);
  final String text;
}
