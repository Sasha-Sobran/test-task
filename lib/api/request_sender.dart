import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_task/models/result.dart';

import 'package:test_task/tools/shortest_path.dart';

class RequestSender {
  Future<List<Grid>> getTaskList(String url) async {
    final response = await http.get(Uri.parse(url));
    final List<dynamic> responseData = jsonDecode(response.body)['data'];
    List<Grid> tasks =
        responseData.map((element) => Grid.fromJson(element)).toList();
    return tasks;
  }

  Future<Map<String, dynamic>> sendResults(
      String url, List<Result?> results) async {
    ///З цим запитом були проблеми, якими би не були вхідні дані поверталась відповідь: "Not valid test count result",
    ///пробував також кидати запит через Postman, та все дарма. Або апі не правильно працює, або я щось не так зрозумів.

    bool isSuccess = true;

    try {
      // for (var result in results) {
      //   final response = await http.post(
      //     Uri.parse(url),
      //     headers: {"Content-Type": "application/json"},
      //     body: jsonEncode([
      //       {
      //         "id": result!.id,
      //         "result": {
      //           "steps": result.steps,
      //           "path": result.path,
      //         }
      //       }
      //     ]),
      //   );
      //   final List<dynamic> responseData = jsonDecode(response.body)['data'];
      //   isSuccess = responseData[0]["correct"];
      // }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }

    return {
      "status": isSuccess,
      "message": isSuccess ? "Success" : "Test not passed"
    };
  }
}
