import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/utils/dimensions.dart';

import '../../../controller/wishlist_controller.dart';
import '../../../core/helper/help_me.dart';
import '../../../core/helper/route_helper.dart';
import '../../../data/model/common/course.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';

class SearchBody extends StatelessWidget {
  final List<Course> courseList;
  const SearchBody({Key? key, required this.courseList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (courseList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeSmall),
              child: Text(
                  "Search for result in ${courseList.length} ${courseList.length > 1 ? 'courses' : 'course'}"),
            ),
          //WishListCourse()
          searchResultUi(context)
        ],
      ),
    );
  }

  Widget searchResultUi(BuildContext context) => Expanded(
        child: ListView.builder(
          itemCount: courseList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return searchResulWidget(context, courseList[index]);
          },
        ),
      );

  Widget searchResulWidget(BuildContext context, Course course) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(RouteHelper.courseDetailsScreen, arguments: course.id),
      child: Container(
        width: width / 1.2,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.radiusSmall)),
                child: Image.network(
                  course.thumbnail ?? '',
                  width: 70,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset(Images.placeholder),
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                width: Dimensions.paddingSizeSmall,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width / 1.8,
                          child: Text(
                            course.title ?? "",
                            style: robotoMedium.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall),
                      child: Row(
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.6),
                                    fontSize: Dimensions.fontSizeExtraSmall),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeSmall,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(Images.profileSmall),
                              const SizedBox(
                                width: Dimensions.paddingSizeMint,
                              ),
                              Text(
                                "${course.totalEnrolls} ${'enroll'.tr}",
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.6),
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
                          //"\$27.00",
                          calculateCoursePrice(course),
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                        InkWell(
                          onTap: () => Get.find<WishListController>()
                              .addToCart(course.id!, 'course'),
                          child: Text(
                            'add_to_cart'.tr,
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.fontSizeSmall),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
