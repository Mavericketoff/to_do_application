import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/core/theme/application_style.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/core/theme/colors/dark_colors.dart';
import 'package:to_do_application/app/core/theme/colors/light_colors.dart';
import 'package:to_do_application/app/core/utils/network_util.dart';
import 'package:to_do_application/app/core/utils/persistence_util.dart';
import 'package:to_do_application/app/features/home/presentation/home_screen.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';
import 'package:to_do_application/app/features/tasks/utils/api/local_storage_util.dart';
import 'package:to_do_application/app/features/tasks/utils/repository/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/tasks_detail_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.localStorage});

  final LocalStorageUtil localStorage;

  @override
  Widget build(BuildContext context) {
    final persistenceUtil = PersistenceUtil();
    final networkUtil = NetworkUtil(persistenceUtil: persistenceUtil);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(
            isDark: Theme.of(context).brightness == Brightness.dark,
          ),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(
            repository: Repository(
              localStorage: localStorage,
              persistenceUtil: persistenceUtil,
              networkUtil: networkUtil,
            ),
            persistenceUtil: persistenceUtil,
          )..add(const LoadTasks()),
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
