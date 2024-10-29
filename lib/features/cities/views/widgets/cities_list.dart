import 'package:api_client/api_client.dart';
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
          (_) => CitiesListView(
              cities: state.cities,
            ),
        };
      },
    );
  }
}

class CitiesListView extends StatefulWidget {
  const CitiesListView({
    required this.cities,
    super.key,
  });

  final List<City> cities;

  @override
  State<CitiesListView> createState() => _CitiesListViewState();
}

class _CitiesListViewState extends State<CitiesListView> {
  @override
  Widget build(BuildContext context) {
    if (widget.cities.isEmpty) {
      return const Center(
        child: Text('No cities'),
      );
    }

    return ListView.builder(
      itemCount: widget.cities.length,
      itemBuilder: (context, index) {
        final city = widget.cities[index];
        final country = city.country;
        return ListTile(
          dense: true,
          leading: Text(city.id.toString()),
          title: Text(city.name),
          subtitle: country != null ? Text(country.name) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
