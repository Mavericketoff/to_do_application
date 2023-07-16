class NavigationState {
  final bool isHomeScreen;
  final bool isDetailsScreen;
  final bool isUnknown;
  final bool isNewTaskScreen;
  final String? selectedTaskId;

  NavigationState({
    this.isHomeScreen = true,
    this.isDetailsScreen = false,
    this.isUnknown = false,
    this.isNewTaskScreen = false,
    this.selectedTaskId,
  });

  NavigationState.home() : this();

  NavigationState.details(String taskId)
      : this(
          isHomeScreen: false,
          isDetailsScreen: true,
          selectedTaskId: taskId,
        );

  NavigationState.unknown()
      : this(
          isHomeScreen: false,
          isUnknown: true,
        );

  NavigationState.newTask()
      : this(
          isHomeScreen: false,
          isNewTaskScreen: true,
        );
}
