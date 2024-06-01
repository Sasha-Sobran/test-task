import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "loading_state.dart";

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(const LoadingInitial());

  void setLoadingState(bool isLoaded, int progress) => emit(LoadingState(
        isLoaded: isLoaded,
        progress: progress,
      ));
}
