import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/api/request_sender.dart';
import 'package:test_task/components/my_pretty_button.dart';
import 'package:test_task/cubits/api_url_cubit/api_url_cubit.dart';
import 'package:test_task/cubits/loading_cubit.dart/loading_cubit.dart';
import 'package:test_task/cubits/results_cubit/results_cubit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = false;

  void _showAlertDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
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
    final resultsCubit = context.read<ResultsCubit>();

    setState(() {
      isLoading = true;
    });

    Map result = await RequestSender().sendResults(
      apiUrlCubit.state.url,
      resultsCubit.state.results,
    );

    //симулюємо надсилання запиту...
    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context).pushNamed("/results-screen");

    if (result["status"]) {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      _showAlertDialog(result["message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Process screen",
        ),
      ),
      body: BlocBuilder<LoadingCubit, LoadingState>(
        builder: (context, state) {
          return Column(
            children: [
              const Expanded(child: SizedBox()),
              Column(
                children: [
                  if (state.isLoaded)
                    const Text(
                      "All calculation are finished, you can send your results to server",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${state.progress}%",
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: CircularProgressIndicator(
                        color: Colors.lightBlue,
                        value: state.progress / 100,
                      ),
                    ),
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              if (isLoading) const CircularProgressIndicator(),
              if (state.isLoaded)
                MyPrettyButton(
                  buttonCallBack: isLoading ? null : _buttonCallBack,
                  buttonText: "Send results to server",
                )
            ],
          );
        },
      ),
    );
  }
}
