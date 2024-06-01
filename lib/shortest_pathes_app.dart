import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_task/cubits/api_url_cubit/api_url_cubit.dart';
import 'package:test_task/cubits/grids_cubit/grids_cubit.dart';
import 'package:test_task/cubits/loading_cubit.dart/loading_cubit.dart';
import 'package:test_task/cubits/results_cubit/results_cubit.dart';

import 'package:test_task/screens/base_url_screen.dart';
import 'package:test_task/screens/loading_screen.dart';
import 'package:test_task/screens/results_screen.dart';

class ShortestPathesApp extends StatelessWidget {
  const ShortestPathesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApiUrlCubit(),
        ),
        BlocProvider(
          create: (context) => GridsCubit(),
        ),
        BlocProvider(
          create: (context) => LoadingCubit(),
        ),
        BlocProvider(
          create: (context) => ResultsCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          "/home-screen": (context) => const BaseUrlScreen(),
          "/loading-screen": (context) => const LoadingScreen(),
          "/results-screen": (context) => const ResultsScreen(),
        },
        home: const BaseUrlScreen(),
      ),
    );
  }
}
