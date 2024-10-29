import 'package:cities_of_the_world/features/cities/bloc/cities_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitiesList extends StatelessWidget {
  const CitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CitiesState>(
      bloc: context.read<CitiesCubit>(),
      builder: (context, state) {
        return switch (state.status) {
          (CitiesStatus.loading) => const Center(
              child: CircularProgressIndicator(),
            ),
          (CitiesStatus.failure) => const Center(
              child: Text('Failed to fetch cities'),
            ),
          (CitiesStatus.initial) => const SizedBox(),
          (_) => ListView.builder(
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                final city = state.cities[index];
                return ListTile(
                  title: Text(city.name),
                  //subtitle: Text(city.country.name),
                );
              },
            ),
        };
      },
    );
  }
}
