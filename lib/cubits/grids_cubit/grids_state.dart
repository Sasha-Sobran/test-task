part of "grids_cubit.dart";

@immutable
class GridsState {
  final List<Grid> grids;

  const GridsState({required this.grids});
}

final class GridsInitial extends GridsState {
  GridsInitial() : super(grids: []);
}
