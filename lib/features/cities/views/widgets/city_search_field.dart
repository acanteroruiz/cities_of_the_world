import 'package:cities_of_the_world/features/cities/bloc/cities_cubit.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySearchField extends StatelessWidget {
  const CitySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final initialDataIsFromCache =
        context.watch<CitiesCubit>().state.initialDataIsFromCache;
    final hintLabel = context.watch<CitiesCubit>().state.hintLabel;
    final currentFilter = context.watch<CitiesCubit>().state.currentFilter;

    return TextField(
      controller: TextEditingController.fromValue(
        TextEditingValue(
          text: currentFilter,
          selection: TextSelection.collapsed(
            offset: currentFilter.length,
          ),
        ),
      ),
      onChanged: (value) async {
        return EasyDebounce.debounce(
          'search-cities-debounce',
          const Duration(milliseconds: 500),
          () => context.read<CitiesCubit>().fetchCities(
                filter: value,
              ),
        );
      },
      decoration: InputDecoration(
        hintText: hintLabel,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: initialDataIsFromCache || currentFilter.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () async =>
                    context.read<CitiesCubit>().fetchCities(refresh: true),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
