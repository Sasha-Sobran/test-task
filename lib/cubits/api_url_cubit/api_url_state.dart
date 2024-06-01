part of "api_url_cubit.dart";

@immutable
class ApiUrlState {
  final String url;

  const ApiUrlState({required this.url});
}

final class ApiUrlInitial extends ApiUrlState {
  const ApiUrlInitial() : super(url: "");
}
