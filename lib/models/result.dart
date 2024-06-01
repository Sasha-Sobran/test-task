import 'package:test_task/tools/shortest_path.dart';

class Result {
  final String id;
  final List<dynamic> steps;
  final String path;
  final Grid grid;

  const Result({
    required this.id,
    required this.steps,
    required this.path,
    required this.grid,
  });
}
