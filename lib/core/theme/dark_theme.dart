import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  useMaterial3: true,
  fontFamily: 'Ubuntu',
  // primaryColor: const Color(0xFF2B292E),
  primaryColor: const Color(0xff23A462),
  dividerColor: const Color(0xff999999),
  primaryColorLight: const Color(0xFFF0F4F8),
  primaryColorDark: const Color(0xFF10324A),
  secondaryHeaderColor: const Color(0xFF9BB8DA),
  disabledColor: const Color(0xFF8797AB),
  scaffoldBackgroundColor: const Color(0xFF151515),
  appBarTheme: const AppBarTheme(color: Color(0xFF151417)),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: Color(0xFF2B292E)),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFC0BFBF),
  focusColor: const Color(0xFF484848),
  hoverColor: const Color(0x400461A5),
  shadowColor: const Color(0x33e2f1ff),
  cardColor: const Color(0xFF151417),
  sliderTheme: const SliderThemeData(
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFFFFFFFF))),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF23A462),
    secondary: Color(0xFFf57d00),
    tertiary: (Color(0xFFFF6767)),
    onPrimary: Color(0xff1c3c5d),
  )
      .copyWith(error: const Color(0xFFdd3135))
      .copyWith(background: const Color(0xff010D15)),
);

// semi-dark-light-color