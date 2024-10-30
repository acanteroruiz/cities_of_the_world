import 'package:cities_of_the_world/features/cities/bloc/cities_cubit.dart';
import 'package:cities_of_the_world/features/cities/views/widgets/cities_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CitiesCubit()..fetchCities(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: const Text(
        //   'Cities of the World',
        // ),
        /// add a TextFieldInput to search chities
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search cities',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      body: const Center(
        child: CitiesList(),
      ),
    );
  }
}
