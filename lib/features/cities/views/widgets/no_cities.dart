import 'package:flutter/material.dart';

class NoCities extends StatelessWidget {
  const NoCities({
    required this.label,
    required this.iconData,
    super.key,
  });

  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
          ),
          Icon(
            iconData,
            size: 100,
            color: Theme.of(context).primaryColorDark,
          ),
        ],
      ),
    );
  }
}
