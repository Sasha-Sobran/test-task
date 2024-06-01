import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/api/request_sender.dart';

import 'package:test_task/tools/shortest_path.dart';

part "grids_state.dart";

class GridsCubit extends Cubit<GridsState> {
  GridsCubit() : super(GridsInitial());

  Future<bool> setGrids(url) async {
    try {
      var grids = await RequestSender().getTaskList(url);

      emit(GridsState(grids: grids));
      return true;
    } catch (e) {
      return false;
    }
  }
}
