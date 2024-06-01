import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_task/cubits/api_url_cubit/api_url_cubit.dart';
import 'package:test_task/cubits/grids_cubit/grids_cubit.dart';
import 'package:test_task/cubits/loading_cubit.dart/loading_cubit.dart';
import 'package:test_task/cubits/results_cubit/results_cubit.dart';

import 'package:test_task/components/my_pretty_button.dart';
import 'package:test_task/models/result.dart';
import 'package:test_task/tools/shortest_path.dart';

class BaseUrlScreen extends StatefulWidget {
  const BaseUrlScreen({super.key});

  @override
  State<BaseUrlScreen> createState() => _BaseUrlScreenState();
}

class _BaseUrlScreenState extends State<BaseUrlScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _showAlertDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("There is some problems with url..."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _buttonCallBack() async {
    final apiUrlCubit = context.read<ApiUrlCubit>();
    final gridCubit = context.read<GridsCubit>();
    final loadingCubit = context.read<LoadingCubit>();
    final resultsCubit = context.read<ResultsCubit>();

    loadingCubit.setLoadingState(false, 0);

    final String url = _controller.value.text;
    apiUrlCubit.setUrl(url);

    bool isSuccess = await gridCubit.setGrids(url);

    if (isSuccess) {
      Navigator.of(context).pushNamed("/loading-screen");

      List<Grid> grids = gridCubit.state.grids;
      List<Result?> results = [];

      for (int i = 0; i < grids.length; i++) {
        //додано для того, щоб було краще видно зміну прогресу
        await Future.delayed(const Duration(seconds: 2));

        results.add(grids[i].findShortestPath());

        loadingCubit.setLoadingState(
            i == grids.length - 1, ((100 / grids.length) * (i + 1)).toInt());
      }
      resultsCubit.setResults(results);
    } else {
      _showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Home Screen",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Set valid API base in order to continue",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.keyboard_double_arrow_right_rounded),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _controller,
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          MyPrettyButton(
            buttonText: "Start counting process",
            buttonCallBack: _buttonCallBack,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
