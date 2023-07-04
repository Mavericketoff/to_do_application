import 'package:flutter/material.dart';
import 'package:to_do_application/app/core/theme/colors.dart';
import 'package:to_do_application/app/core/theme/text_style.dart';

class AppStyle {
  final MyColors myColors;

  AppStyle(this.myColors);

  ThemeData get themeData => ThemeData(
        brightness: myColors.brightness,
        textTheme: appTextStyles.textTheme,
        scaffoldBackgroundColor: myColors.colorBackPrimary,
        dialogBackgroundColor: myColors.colorBackSecondary,
        hintColor: myColors.colorLabelTertiary,
        dividerColor: myColors.colorSupportSeparator,
        disabledColor: myColors.colorLabelDisable,
      );

  AppTextStyles get appTextStyles => AppTextStyles(myColors: myColors);
}
