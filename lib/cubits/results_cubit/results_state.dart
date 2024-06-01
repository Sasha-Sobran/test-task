part of "results_cubit.dart";

@immutable
class ResultsState {
  final List<Result?> results;

  const ResultsState({required this.results});
}

final class ResultsInitial extends ResultsState {
  ResultsInitial() : super(results: []);
}
