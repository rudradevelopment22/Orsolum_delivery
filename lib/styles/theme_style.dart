import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/constant/color_const.dart';

import 'text_style.dart';

abstract class ThemeStyle {
  static ThemeData get light => ThemeData(
    fontFamily: "OpenSans",
    primaryColor: ColorConst.primary,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      titleTextStyle: TextStyles.subTitle1Semibold.copyWith(
        color: ColorConst.neutralShade90,
      ),
      iconTheme: IconThemeData(color: ColorConst.neutralShade90),
      actionsIconTheme: IconThemeData(color: ColorConst.neutralShade90),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConst.primary,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        foregroundColor: Colors.white,
        disabledBackgroundColor: ColorConst.primaryShade10,
        textStyle: TextStyles.buttonRegular,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: ColorConst.primary,
        textStyle: TextStyles.button.copyWith(color: ColorConst.primary),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.body2.copyWith(color: ColorConst.neutralShade40),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorConst.neutralShade10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorConst.neutralShade10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorConst.neutralShade10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    ),
  );
}
