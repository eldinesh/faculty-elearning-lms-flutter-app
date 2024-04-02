import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../data/model/common/course.dart';

class CourseWidget extends StatelessWidget {
  final Course? course;
  const CourseWidget({Key? key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getCourseDetailsScreenRoute(),
            arguments: course?.id);
      },
      child: Container(
        width: 155,
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.06)),
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double containerHeight = constraints.maxHeight;
          double containerWidth = constraints.maxWidth;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                child: CustomImage(
                  image:course?.thumbnail ?? "",
                  height: containerHeight * 0.60,
                  width: containerWidth,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course?.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: Dimensions.fontSizeSemiSmall),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Images.playSmall,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(.6)),
                              const SizedBox(
                                width: Dimensions.paddingSizeMint,
                              ),
                              Text(
                                "${course?.totalLessons ?? 0} Lessons",
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeExtraSmall,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(.6)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(Images.profileSmall,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(.6)),
                              const SizedBox(width: 2),
                              Text(
                                "${course?.totalLessons ?? 0}",
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(.6),
                                    fontSize: Dimensions.fontSizeExtraSmall),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${course?.price}",
                          style: robotoRegular.copyWith(
                              color: Get.isDarkMode
                                  ? Colors.green
                                  : Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(Images.starFill),
                            const SizedBox(
                              width: Dimensions.paddingSizeExtraSmall,
                            ),
                            Text(
                              course?.totalRating ?? "0.0",
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
