import 'package:flutter/material.dart';

import '../../../features/home/presentation/home_screen.dart';
import '../../../features/tasks_detail/presentation/tasks_detail_screen.dart';
import '../../../features/unknown/presentation/unknown_page.dart';
import 'navigation_state.dart';

class CustomRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  CustomRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState? state;

  @override
  NavigationState get currentConfiguration {
    return state ?? NavigationState.home();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (state == null || state!.isHomeScreen)
          MaterialPage(
            key: const ValueKey('HomeScreenPage'),
            child: HomeScreen(
              onTaskTap: _showTaskDetails,
              onNewTaskButtonTap: _showNewTaskScreen,
            ),
          ),
        if (state?.isDetailsScreen ?? false)
          if (state!.selectedTaskId != null)
            MaterialPage(
              key: ValueKey('TaskDetailsScreenPage-${state!.selectedTaskId}'),
              child: TaskDetailsScreen(
                taskId: state!.selectedTaskId!,
                isNewTask: false,
              ),
            ),
        if (state?.isUnknown ?? false)
          const MaterialPage(
            key: ValueKey('UnknownScreenPage'),
            child: UnknownScreen(),
          ),
        if (state?.isNewTaskScreen ?? false)
          const MaterialPage(
            key: ValueKey('NewTaskScreenPage'),
            child: TaskDetailsScreen(
              taskId: 'unknownPage',
              isNewTask: true,
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;

        state = NavigationState.home();
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    state = configuration;
    notifyListeners();
  }

  void _showTaskDetails(String taskId) {
    state = NavigationState.details(taskId);
    notifyListeners();
  }

  void _showNewTaskScreen() {
    state = NavigationState.newTask();
    notifyListeners();
  }
}
