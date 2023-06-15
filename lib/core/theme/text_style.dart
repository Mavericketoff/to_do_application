import 'package:flutter/material.dart';
import 'package:to_do_application/core/theme/colors.dart';

class AppTextStyles {
  final MyColors myColors;
  AppTextStyles({required this.myColors});

  TextStyle get font {
    return const TextStyle().copyWith(color: myColors.colorLabelPrimary);
  }

  TextStyle get largeTitle =>
      font.copyWith(fontSize: 32, height: 38 / 32, fontWeight: FontWeight.w500);

  TextStyle get title =>
      font.copyWith(fontSize: 20, height: 32 / 20, fontWeight: FontWeight.w500);

  TextStyle get button =>
      font.copyWith(fontSize: 14, height: 24 / 14, fontWeight: FontWeight.w500);

  TextStyle get body =>
      font.copyWith(fontSize: 16, height: 20 / 16, fontWeight: FontWeight.w400);

  TextStyle get subhead =>
      font.copyWith(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w400);

  TextTheme get textTheme => TextTheme(
        titleLarge: largeTitle,
        titleMedium: title,
        labelMedium: button,
        bodyMedium: body,
        titleSmall: subhead,
      );
}
