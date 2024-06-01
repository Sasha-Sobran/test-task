import 'dart:collection';

import 'package:test_task/models/result.dart';

class Point {
  int x;
  int y;
  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class Grid {
  final String id;
  final List<dynamic> field;
  late final Point start;
  late final Point end;

  Grid({required this.id, required this.field, required start, required end}) {
    this.start = Point(start["x"], start["y"]);
    this.end = Point(end["x"], end["y"]);
  }

  factory Grid.fromJson(Map<String, dynamic> json) => Grid(
        id: json["id"],
        field: json["field"],
        start: json["start"],
        end: json["end"],
      );

  List<Point> getNeighbors(Point point) {
    List<Point> neighbors = [];
    int fieldLength = field.length;
    int fieldWidth = field[0].length;

    List<List<int>> directions = [
      [0, 1],
      [1, 0],
      [0, -1],
      [-1, 0],
      [1, 1],
      [-1, -1],
      [1, -1],
      [-1, 1]
    ];

    for (var direction in directions) {
      int dx = direction[0];
      int dy = direction[1];
      int newX = point.x + dx;
      int newY = point.y + dy;

      if (newX >= 0 &&
          newX < fieldLength &&
          newY >= 0 &&
          newY < fieldWidth &&
          field[newX][newY] != 'X') {
        neighbors.add(Point(newX, newY));
      }
    }

    return neighbors;
  }

  Result? findShortestPath() {
    Queue<List<Point>> queue = Queue();
    Set<Point> visited = {};

    queue.add([start]);
    visited.add(start);

    while (queue.isNotEmpty) {
      List<Point> path = queue.removeFirst();
      Point current = path.last;

      if (current == end) {
        List steps = [];
        String pathString = "";

        for (int i = 0; i < path.length; i++) {
          Point point = path[i];

          int localX = point.x;
          int localY = point.y;

          steps.add({"x": localX.toString(), "y": localY.toString()});
          i == path.length - 1
              ? pathString = "$pathString($localX,$localY)"
              : pathString = "$pathString($localX,$localY)->";
        }

        return Result(id: id, steps: steps, path: pathString, grid: this);
      }

      for (var neighbor in getNeighbors(current)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          List<Point> newPath = List.from(path)..add(neighbor);
          queue.add(newPath);
        }
      }
    }
    return null;
  }
}
