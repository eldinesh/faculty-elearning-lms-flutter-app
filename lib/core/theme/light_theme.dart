import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
  fontFamily: 'Ubuntu',
  primaryColor: const Color(0xFF23A462),
  // primaryColor: const Color(0xFF003EFF),
  primaryColorLight: const Color(0xFFF6F6F6),
  dividerColor: const Color(0xff666666),
  primaryColorDark: const Color(0xFF10324A),
  secondaryHeaderColor: const Color(0xFF9BB8DA),
  disabledColor: const Color(0xFF8797AB),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  brightness: Brightness.light,
  hintColor: const Color(0xFFC0BFBF),
  focusColor: const Color(0xFFFFF9E5),
  hoverColor: const Color(0xFFF1F7FC),
  shadowColor: Colors.grey[300],
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(color: Color(0xFF23A462)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
  sliderTheme: const SliderThemeData(
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF0461A5))),
  colorScheme: const ColorScheme.light(
          primary: Color(0xFF23A462),
          secondary: Color(0xFFFF9900),
          outline: Color(0xFFFDCC0D),
          error: Color(0xFFFF6767),
          background: Color(0xffFCFCFC),
          tertiary: Color(0xFFd35221))
      .copyWith(background: const Color(0xffFCFCFC))
      .copyWith(error: const Color(0xFFFF6767)),
);
