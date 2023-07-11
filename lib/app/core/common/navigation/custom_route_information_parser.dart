import 'package:flutter/material.dart';

import 'navigation_state.dart';

class CustomRouteInformationParser
    extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');

    if (uri.pathSegments.isEmpty) {
      return NavigationState.home();
    } else if (uri.pathSegments.length == 1 &&
        uri.pathSegments.first == 'details') {
      final taskId = uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
      return NavigationState.details(taskId!);
    } else if (uri.pathSegments.length == 1 &&
        uri.pathSegments.first == 'unknown') {
      return NavigationState.unknown();
    } else if (uri.pathSegments.length == 1 &&
        uri.pathSegments.first == 'new') {
      return NavigationState.newTask();
    }

    return NavigationState.home();
  }

  @override
  RouteInformation restoreRouteInformation(NavigationState configuration) {
    if (configuration.isHomeScreen) {
      return const RouteInformation(location: '/');
    } else if (configuration.isDetailsScreen) {
      final taskId = configuration.selectedTaskId ?? '';
      return RouteInformation(location: '/details/$taskId');
    } else if (configuration.isUnknown) {
      return const RouteInformation(location: '/unknown');
    } else if (configuration.isNewTaskScreen) {
      return const RouteInformation(location: '/new');
    }

    return const RouteInformation(location: '/');
  }
}
