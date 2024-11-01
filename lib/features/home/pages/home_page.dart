import 'package:cities_of_the_world/features/cities/bloc/cities_cubit.dart';
import 'package:cities_of_the_world/features/cities/views/widgets/cities_list.dart';
import 'package:cities_of_the_world/features/cities/views/widgets/city_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CitiesCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const CitySearchField(),
      ),
      body: const CitiesList(),
    );
  }
}
