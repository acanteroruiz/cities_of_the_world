import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';

class CityItem extends StatelessWidget {
  const CityItem({
    required this.city,
    super.key,
  });

  final City city;

  @override
  Widget build(BuildContext context) {
    final country = city.country;
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: ListTile(
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
      ),
    );
  }
}
