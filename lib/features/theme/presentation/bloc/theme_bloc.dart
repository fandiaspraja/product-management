import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:labamu/core/local_storage/shared_preferences/shared_preferences_helper.dart';
import 'package:labamu/core/theme/app_theme.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEventBloc, ThemeStateBloc> {
  final SharedPreferencesHelper sharedPreferencesHelper;

  ThemeBloc(this.sharedPreferencesHelper) : super(ThemeInitial()) {
    on<LoadThemeEvent>((event, emit) async {
      emit(ThemeLoading());

      try {
        final themeMode = sharedPreferencesHelper.getThemeMode();

        emit(ThemeLoaded(themeMode));
      } catch (error) {
        emit(ThemeError(error.toString()));
      }
    });

    on<ChangeThemeEvent>((event, emit) async {
      emit(ThemeLoading());

      try {
        await sharedPreferencesHelper.saveThemeMode(event.themeMode);

        emit(ThemeLoaded(event.themeMode));
      } catch (error) {
        emit(ThemeError(error.toString()));
      }
    });
  }
}
