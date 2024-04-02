import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customCheckBox(bool value) {
  return Container(
    height: 22,
    width: 22,
    decoration: BoxDecoration(
        color: value ? Theme.of(Get.context!).colorScheme.primary : null,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .color!
                .withOpacity(0.5),
            style: BorderStyle.solid)),
    child: value
        ? const Center(
            child: Icon(
            Icons.done,
            color: Colors.white,
            size: 12,
          ))
        : null,
  );
}

Widget customCheckBoxRectangle(bool value) {
  return Container(
    height: 22,
    width: 22,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .color!
                .withOpacity(0.5),
            style: BorderStyle.solid)),
    child: value
        ? Center(
            child: Icon(
            Icons.done,
            color: value
                ? Theme.of(Get.context!).colorScheme.primary
                : Colors.white,
            size: 13,
          ))
        : null,
  );
}

Widget customCheckBoxCircle(bool value) {
  return Container(
    height: 22,
    width: 22,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: Theme.of(Get.context!).textTheme.bodyLarge!.color!.withOpacity(0.5),
            style: BorderStyle.solid)),
    child: value
        ? Center(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value ? Theme.of(Get.context!).colorScheme.primary : Colors.white,

          ),
          width: 11,
          height: 11,
        ))
        : null,
  );

  
  
}
