import 'package:cities_of_the_world/features/cities/bloc/cities_cubit.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySearchField extends StatelessWidget {
  const CitySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        hintText: 'Search cities',
        prefixIcon: const Icon(Icons.search),
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
