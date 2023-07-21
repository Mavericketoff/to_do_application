import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme extends InheritedWidget {
  final MyColors colors;
  const AppTheme({required this.colors, required super.child, super.key});

  @override
  bool updateShouldNotify(AppTheme oldWidget) => colors != oldWidget.colors;

  static AppTheme of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();

    if (theme == null) {
      throw Exception('No AppTheme in widget tree. Wrap tree in AppTheme');
    }

    return theme;
  }
}
