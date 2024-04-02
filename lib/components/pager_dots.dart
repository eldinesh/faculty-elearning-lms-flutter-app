import 'package:flutter/material.dart';
import 'package:lms_user_app/utils/dimensions.dart';

class PagerDot extends StatelessWidget {
  const PagerDot({Key? key, required this.index, required this.currentIndex}) : super(key: key);
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: Dimensions.paddingSizeExtraSmall,
      width:currentIndex == index ? Dimensions.paddingSizeLarge:Dimensions.paddingSizeExtraSmall,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}