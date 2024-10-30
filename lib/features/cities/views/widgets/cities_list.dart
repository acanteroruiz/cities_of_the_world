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
        final stateRecord = (state.status, state.cities.isEmpty);
        return switch (stateRecord) {
          (CitiesStatus.initial, _) => const SizedBox(),
          (CitiesStatus.loading, true) => const Center(
              child: CircularProgressIndicator(),
            ),
          (CitiesStatus.failure, _) => const Center(
              child: Text('Failed to fetch cities'),
            ),
          (_, true) => const Center(
              child: Text('No cities'),
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
    final cities = context.select((CitiesCubit cubit) => cubit.state.cities);
    if (cities.isEmpty) {
      return const Center(
        child: Text('No cities'),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        final country = city.country;
        return index >= cities.length
            ? const BottomLoader()
            : ListTile(
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
    return currentScroll >= (maxScroll * 0.82);
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
