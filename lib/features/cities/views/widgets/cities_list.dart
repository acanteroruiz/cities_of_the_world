import 'package:cities_of_the_world/features/cities/bloc/cities_cubit.dart';
import 'package:cities_of_the_world/features/cities/views/widgets/bottom_loader.dart';
import 'package:cities_of_the_world/features/cities/views/widgets/city_list_item.dart';
import 'package:cities_of_the_world/features/cities/views/widgets/no_cities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitiesList extends StatelessWidget {
  const CitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CitiesState>(
      bloc: context.read<CitiesCubit>(),
      builder: (context, state) {
        final stateRecord = (state.status, state.cities.isEmpty);
        return switch (stateRecord) {
          (CitiesStatus.initial, true) => const NoCities(
              label: 'No cities yet. Use the search field to find cities.',
              iconData: Icons.search,
            ),
          (CitiesStatus.loading, true) => const Center(
              child: CircularProgressIndicator(),
            ),
          (CitiesStatus.failure, true) => const NoCities(
              label: 'Failed to fetch cities.',
              iconData: Icons.error,
            ),
          (_, true) => const NoCities(
              label: 'No cities found.',
              iconData: Icons.remove_red_eye,
            ),
          (_, _) => const CitiesListView(),
        };
      },
    );
  }
}

class CitiesListView extends StatefulWidget {
  const CitiesListView({super.key});

  @override
  State<CitiesListView> createState() => _CitiesListViewState();
}

class _CitiesListViewState extends State<CitiesListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final cities = context.watch<CitiesCubit>().state.cities;

    return ListView.builder(
      controller: _scrollController,
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        return index >= cities.length
            ? const BottomLoader()
            : CityItem(city: city);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CitiesCubit>().updatePage();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
