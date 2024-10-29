import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          title,
        ),
      ),
      body: const Center(
        child: Text('Cities of the World'),
      ),
    );
  }
}
