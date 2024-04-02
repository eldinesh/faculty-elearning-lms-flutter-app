import 'package:flutter/material.dart';
import 'package:get/get.dart';

const robotoLight = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

const robotoRegular = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

const robotoMedium = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

const robotoBold = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
);

const robotoSemiBold = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

List<BoxShadow>? searchBoxShadow = Get.isDarkMode ? null : [const BoxShadow(
    offset: Offset(0,3),
    color: Color(0x208F94FB), blurRadius: 5, spreadRadius: 2)];

//card boxShadow
List<BoxShadow>? cardShadow = Get.isDarkMode? null:[BoxShadow(
  offset: const Offset(0, 1),
  blurRadius: 2,
  color: Colors.black.withOpacity(0.15),
)];


List<BoxShadow>? shadow = Get.isDarkMode ? [BoxShadow(
    offset: const Offset(0,3),
    color: Colors.grey[100]!, blurRadius: 1, spreadRadius: 2)] : [BoxShadow(
    offset: const Offset(0,3),
    color: Colors.grey[100]!, blurRadius: 1, spreadRadius: 2)];