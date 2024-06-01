import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/components/result_list_item.dart';
import 'package:test_task/cubits/results_cubit/results_cubit.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResultsCubit resultCubit = context.read<ResultsCubit>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        title: const Text("Results list screen"),
      ),
      body: ListView.builder(
        itemCount: resultCubit.state.results.length,
        itemBuilder: (context, index) {
          return ResultsListItem(
            result: resultCubit.state.results[index],
          );
        },
      ),
    );
  }
}
