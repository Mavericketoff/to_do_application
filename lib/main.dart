import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/core/common/error_handler.dart';
import 'package:to_do_application/core/common/logger.dart';
import 'package:to_do_application/core/theme/application_style.dart';
import 'package:to_do_application/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/core/theme/colors/dark_colors.dart';
import 'package:to_do_application/core/theme/colors/light_colors.dart';
import 'package:to_do_application/features/home/presentation/home_screen.dart';
import 'package:to_do_application/features/tasks/block/tasks_bloc.dart';
import 'package:to_do_application/features/tasks_detail/presentation/tasks_detail_screen.dart';

void main() {
  runZonedGuarded(() {
    initLogger();
    logger.info('Start main');

    ErrorHandler.init();
    runApp(
      const MainApp(),
    );
  }, ErrorHandler.recordError);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(
            isDark: Theme.of(context).brightness == Brightness.dark,
          ),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final currentPalette = state.isDarkTheme ? darkColors : lightColors;
          return MaterialApp(
            theme: AppStyle(currentPalette).themeData,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (context) => const HomeScreen(),
              '/task_details': (context) => const TaskDetailsScreen()
            },
          );
        },
      ),
    );
  }
}
