import 'package:flutter/material.dart';

import 'package:test_task/models/result.dart';
import 'package:test_task/screens/result_screen.dart';

class ResultsListItem extends StatelessWidget {
  final Result? result;

  const ResultsListItem({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(result: result)),
        );
      },
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            result!.path,
          ),
        ),
      ),
    );
  }
}
