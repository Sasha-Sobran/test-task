import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "api_url_state.dart";

class ApiUrlCubit extends Cubit<ApiUrlState> {
  ApiUrlCubit() : super(const ApiUrlInitial());

  void setUrl(String newUrl) => emit(ApiUrlState(url: newUrl));
}
