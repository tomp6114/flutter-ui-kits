import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme(BuildContext context) {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
    } else {
      final brightness = MediaQuery.platformBrightnessOf(context);
      emit(brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark);
    }
  }

  void setThemeMode(ThemeMode mode) => emit(mode);
}
