import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_task/models/result.dart';

part "results_state.dart";

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit() : super(ResultsInitial());

  void setResults(results) {
    emit(ResultsState(results: results));
  }
}
