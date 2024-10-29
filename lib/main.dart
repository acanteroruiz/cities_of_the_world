import 'package:cities_of_the_world/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cities of the World',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(
        title: 'Cities of the World',
      ),
    );
  }
}
