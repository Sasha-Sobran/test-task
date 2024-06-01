import 'package:flutter/material.dart';

import 'package:test_task/models/result.dart';
import 'package:test_task/tools/shortest_path.dart';

class ResultScreen extends StatelessWidget {
  final Result? result;

  const ResultScreen({super.key, required this.result});

  List<Widget> _generateGridList(Grid grid) {
    List<Widget> gridList = [];

    List field = grid.field;

    for (int i = 0; i < field.length; i++) {
      for (int j = 0; j < field.length; j++) {
        Color color = const Color(0xFFFFFFFF);
        Color textColor = const Color(0xFF000000);

        bool isPartOfPath = result!.steps.any((element) =>
            element["x"] == j.toString() && element["y"] == i.toString());

        if (field[i][j] == "X") {
          color = const Color(0xFF000000);
          textColor = const Color(0xFFFFFFFF);
        } else if (grid.start.x == j && grid.start.y == i) {
          color = const Color(0xFF64FFDA);
        } else if (grid.end.x == j && grid.end.y == i) {
          color = const Color(0xFF009688);
        } else if (isPartOfPath) {
          color = const Color(0xFF4CAF50);
        }

        gridList.add(
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: const Color.fromARGB(255, 156, 163, 160),
                width: 1,
              ),
            ),
            child: Text(
              "($j,$i)",
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    }
    return gridList;
  }

  @override
  Widget build(BuildContext context) {
    List gridList = _generateGridList(result!.grid);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Preview screen"),
        backgroundColor: Colors.lightBlue,
      ),
      body: InteractiveViewer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: result!.grid.field.length,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    result!.grid.field.length * result!.grid.field.length,
                itemBuilder: (context, index) => gridList[index],
              ),
            ),
            Text(
              result!.path,
              style: const TextStyle(fontSize: 22),
            ),
            const Expanded(
              flex: 2,
              child: Text(""),
            )
          ],
        ),
      ),
    );
  }
}
