import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/rating_bar.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CourseShimmer extends StatelessWidget {
  final bool? isEnabled;
  final bool? hasDivider;
  const CourseShimmer(
      {super.key, required this.isEnabled, required this.hasDivider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        color: Colors.grey[Get.isDarkMode ? 700 : 300],
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        enabled: isEnabled!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 20,
                        width: double.maxFinite,
                        color: Colors.grey[400]),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Container(
                      height: 10,
                      width: double.maxFinite,
                      color: Colors.grey[Get.isDarkMode ? 600 : 400],
                      margin: const EdgeInsets.only(
                          right: Dimensions.paddingSizeLarge),
                    ),
                    const RatingBar(rating: 0, size: 12, ratingCount: 0),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Row(children: [
                      Container(
                          height: 15,
                          width: 30,
                          color: Colors.grey[Get.isDarkMode ? 600 : 400]),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Container(
                          height: 10,
                          width: 20,
                          color: Colors.grey[Get.isDarkMode ? 600 : 400]),
                    ]),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
