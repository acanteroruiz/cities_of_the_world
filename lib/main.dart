import 'dart:developer';

import 'package:cities_of_the_world/bloc_observer.dart';
import 'package:cities_of_the_world/features/home/pages/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterError.onError = _trackError;

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      log(
        'ERROR: $error \n STACKTRACE: $stack',
      );
    }
    return true;
  };

  runApp(
    const MyApp(),
  );
}

void _trackError(FlutterErrorDetails details) {
  if (kDebugMode) {
    log(
      'ERROR: ${details.exception} \n STACKTRACE: ${details.stack}',
    );
  }
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
      home: const HomePage(),
    );
  }
}
