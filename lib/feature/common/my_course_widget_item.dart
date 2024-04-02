import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/data/model/common/my_course.dart';

import '../../components/custom_image.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class MyCourseWidgetItem extends StatelessWidget {
  final MyCourse course;
  const MyCourseWidgetItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      child: InkWell(
        // onTap: () => Navigator.of(context).pushNamed(RouteHelper.learningScreen, arguments: course.id),
        onTap: () {
          Get.toNamed(RouteHelper.getLearningScreen(
            course.id.toString(),
            course.title!
          ));
        },
        radius: 6,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.06)),
              borderRadius: const BorderRadius.all(Radius.circular(6))),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: CustomImage(
                        width: 60,
                        height: 60,
                        image: course.thumbnail ?? '',
                        placeholder: Images.placeholder,
                      ),
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeSmall,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title ?? '',
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall,
                          ),
                          Text(
                            "${course.completedLessons} Lesson / ${course.totalLessons} Lesson",
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeExtraSmall,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${course.completedPercentage}",
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Get.isDarkMode
                            ? Colors.green
                            : Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    value:
                        calculatePercentage(course.completedPercentage ?? "0%"),
                    valueColor: AlwaysStoppedAnimation<Color>(Get.isDarkMode
                        ? Colors.green.withOpacity(.5)
                        : Theme.of(context).primaryColor.withOpacity(.5)),
                    backgroundColor: Get.isDarkMode
                        ? Colors.green.withOpacity(.1)
                        : Theme.of(context).primaryColor.withOpacity(.1),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  double calculatePercentage(String percentage) {
    return double.parse(percentage.replaceAll('%', '')) / 100;
  }
}
