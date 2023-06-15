import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/core/theme/colors.dart';
import 'package:to_do_application/core/theme/colors/dark_colors.dart';
import 'package:to_do_application/core/theme/colors/light_colors.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required bool isDark})
      : super(ThemeInitial(
          isDarkTheme: isDark,
          colorPalette: isDark ? darkColors : lightColors,
        )) {
    on<ToggleThemeEvent>((event, emit) {
      emit(
        ThemeState(
            isDarkTheme: !state.isDarkTheme,
            colorPalette: state.isDarkTheme ? darkColors : lightColors),
      );
    });
  }
}
