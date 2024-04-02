import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../components/title_view.dart';
import '../../data/model/common/course.dart';

class FeaturedCourse extends StatelessWidget {
  final List<Course> courseList;
  const FeaturedCourse({Key? key, required this.courseList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleView(title: 'featured_courses'.tr),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courseList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: Dimensions.paddingSizeDefault,
                    left: index == 0 ? Dimensions.paddingSizeDefault : 0),
                child: FeaturedCoursesWidget(
                  course: courseList.elementAt(index),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class FeaturedCoursesWidget extends StatelessWidget {
  final Course course;
  const FeaturedCoursesWidget({Key? key, required this.course})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 1.2,
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.06)),
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            child: Image.network(
              course.thumbnail ?? "",
              width: 120,
              height: 120,
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: Dimensions.fontSizeDefault),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Images.playSmall),
                            const SizedBox(
                              width: Dimensions.paddingSizeMint,
                            ),
                            Text(
                              "${course.totalLessons} ${'lessons'.tr}",
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(Images.profileSmall),
                            const SizedBox(
                              width: Dimensions.paddingSizeMint,
                            ),
                            Text(
                              "${course.totalLessons} ${'enroll'.tr}",
                              style: robotoRegular.copyWith(
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
                        calculateCoursePrice(course),
                        style: robotoRegular.copyWith(
                            color: Get.isDarkMode
                                ? Colors.green
                                : Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeSmall),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(Images.starFill),
                          const SizedBox(
                            width: Dimensions.paddingSizeMint,
                          ),
                          Text(
                            course.totalRating ?? "0.0",
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
