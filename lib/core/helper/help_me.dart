import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../data/model/cart_list/cart.dart';
import '../../data/model/common/book.dart';
import '../../data/model/common/course.dart';

const klogTag = "[LMS-Faculty]";
const klogEnabled = true;
DateTime? loginClickTime;

printLog(dynamic data) {
  if (klogEnabled) {
    if (kDebugMode) {
      print("$klogTag${data.toString()}");
    }
  }
}

String calculateCoursePrice(Course course) {
  if (course.isFree!) {
    return "free".tr;
  } else {
    if (course.isDiscounted!) {
      return course.discountedPrice.toString();
    } else {
      return course.price.toString();
    }
  }
}

String calculateBookPrice(BookModel book) {
  if (book.isFree == true) {
    return 'free'.tr;
  } else {
    if (book.isDiscounted == true) {
      return "\$${book.discountedPrice.toString()}";
    } else {
      return '\$${book.price}';
    }
  }
}

String calculateCartPrice(Cart cart) {
  if (cart.isFree == true) {
    return 'free'.tr;
  } else {
    if (cart.isDiscounted == true) {
      return cart.discountedPrice.toString();
    } else {
      return '${cart.price}';
    }
  }
}

bool isRedundentClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    return false;
  }
  if (currentTime.difference(loginClickTime!).inSeconds < 3) {
    return true;
  }

  loginClickTime = currentTime;
  return false;
}

Color randomColorPicker() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}


Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}