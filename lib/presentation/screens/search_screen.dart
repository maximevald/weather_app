import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_application/data/weather_repository.dart';
import 'package:weather_application/domain/weather_current/weather_model.dart';

import 'package:weather_application/presentation/blocs/search_bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(context.read<WeatherRepository>()),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        return TextField(
                          autofocus: true,
                          onChanged: (text) {
                            context
                                .read<SearchBloc>()
                                .add(SearchTextEvent(text));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return switch (state) {
                    SearchEmptyState _ => const SizedBox.shrink(),
                    SearchLoadingState _ => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    SearchErrorState(:final error) => Center(
                        child: Text(
                          error.toString(),
                        ),
                      ),
                    SearchSuccessState(:final WeatherModel weatherModel) =>
                      ListTile(
                        title: Text(weatherModel.name),
                        onTap: () {
                          Navigator.of(context).pop(weatherModel);
                        },
                      ),
                    SearchSuccessState _ => const Center(
                        child: Text('Ничего не найдено'),
                      )
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
