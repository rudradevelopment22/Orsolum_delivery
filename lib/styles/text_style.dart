import 'package:flutter/material.dart';

abstract class TextStyles {
  static TextStyle headline1 = const TextStyle(
    fontSize: 76,
    fontWeight: FontWeight.w600,
    letterSpacing: -1,
  );
  static TextStyle headline2 = const TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );
  static TextStyle headline3 = const TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w600,
  );
  static TextStyle headline4 = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
  );
  static TextStyle headline5 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static TextStyle headline6 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );
  static TextStyle subTitle1 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static TextStyle subTitle1Large = subTitle1.copyWith(
    fontSize: 18,
  );
  static TextStyle subTitle1LargeSemibold = subTitle1Large.copyWith(
    fontWeight: FontWeight.w600,
  );
  static TextStyle subTitle2 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );
  static TextStyle subTitle2Semibold = subTitle2.copyWith(
    fontWeight: FontWeight.w600,
  );
  static TextStyle subTitle2Bold = subTitle2.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle subTitle1Semibold = subTitle2.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle body1 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static TextStyle body2 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static TextStyle buttonLarge = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  static TextStyle button = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
  );
  static TextStyle buttonRegular = button.copyWith(
    fontWeight: FontWeight.w400,
  );

  static TextStyle caption = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.48,
  );

  static TextStyle captionBold = caption.copyWith(
    fontWeight: FontWeight.bold,
  );

  static TextStyle captionSemiBold = caption.copyWith(
    fontWeight: FontWeight.w600,
  );

  static TextStyle overline = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );
  static TextStyle overlineSemibold = overline.copyWith(
    fontWeight: FontWeight.w600,
  );

  static TextStyle overlineBold = overline.copyWith(
    fontWeight: FontWeight.bold,
  );
}
