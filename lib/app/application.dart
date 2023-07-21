import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/core/theme/application_style.dart';
import 'package:to_do_application/app/core/theme/application_theme.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/core/theme/colors/dark_colors.dart';
import 'package:to_do_application/app/core/theme/colors/light_colors.dart';
import 'package:to_do_application/app/core/utils/network_util.dart';
import 'package:to_do_application/app/core/utils/persistence_util.dart';
import 'package:to_do_application/app/core/utils/remote_config_manager.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';
import 'package:to_do_application/app/features/tasks/utils/api/local_storage_util.dart';
import 'package:to_do_application/app/features/tasks/utils/repository/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/common/enums/enviroment.dart';
import 'core/common/enviroment_window.dart';
import 'core/common/navigation/custom_route_information_parser.dart';
import 'core/common/navigation/router_delegate.dart';

class MainApp extends StatelessWidget {
  MainApp({Key? key, required this.localStorage, required this.environment})
      : super(key: key);

  final Environment environment;
  final _routerDelegate = CustomRouterDelegate();
  final _routeInformationParser = CustomRouteInformationParser();

  final LocalStorageUtil localStorage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final brightness = MediaQuery.platformBrightnessOf(context);
          final isDarkTheme = brightness == Brightness.dark;
          final currentColors = isDarkTheme ? darkColors : lightColors;
          final persistenceUtil = PersistenceUtil();
          final remoteConfig = FirebaseRemoteConfig.instance;
          final remoteConfigManager =
              RemoteConfigManager(remoteConfig).importantTaskColorNotifier;
          final networkUtil = NetworkUtil(persistenceUtil: persistenceUtil);

          return ValueListenableBuilder<String>(
            valueListenable: remoteConfigManager,
            builder: (context, color, _) {
              // тут должна быть штучка с цветом задачи, но у меня все ломалось
              // и я не сделал ее (прошу понять и простить)
              return AppTheme(
                colors: currentColors,
                child: MultiBlocProvider(
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
                      final currentPalette =
                          state.isDarkTheme ? darkColors : lightColors;
                      return EnviromentWindow(
                        environment: environment,
                        child: MaterialApp.router(
                          debugShowCheckedModeBanner:
                              environment == Environment.production
                                  ? false
                                  : true,
                          theme: AppStyle(currentPalette).themeData,
                          localizationsDelegates:
                              AppLocalizations.localizationsDelegates,
                          supportedLocales: AppLocalizations.supportedLocales,
                          onGenerateTitle: (context) =>
                              AppLocalizations.of(context)!.appTitle,
                          routerDelegate: _routerDelegate,
                          routeInformationParser: _routeInformationParser,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
