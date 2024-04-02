import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final double strokeWidth;
  const LoadingIndicator({super.key, this.color, this.strokeWidth = 4});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
            color: color ??
                (Get.isDarkMode
                    ? Colors.green
                    : Theme.of(context).primaryColor),
            strokeWidth: strokeWidth));
  }
}
