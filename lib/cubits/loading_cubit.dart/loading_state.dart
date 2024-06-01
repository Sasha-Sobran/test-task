part of "loading_cubit.dart";

@immutable
class LoadingState {
  final bool isLoaded;
  final int progress;

  const LoadingState({required this.isLoaded, required this.progress});
}

final class LoadingInitial extends LoadingState {
  const LoadingInitial() : super(isLoaded: false, progress: 0);
}
