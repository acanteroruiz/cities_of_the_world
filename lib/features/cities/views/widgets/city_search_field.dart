import 'package:flutter/material.dart';

class CitySearchField extends StatelessWidget {
  const CitySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {},
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
