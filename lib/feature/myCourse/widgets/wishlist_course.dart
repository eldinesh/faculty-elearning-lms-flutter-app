import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/wishlist_controller.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/data/model/common/course.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../core/helper/route_helper.dart';

class WishListCourse extends StatelessWidget {
  const WishListCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(
        initState: (state) =>
            Get.find<WishListController>().getWishlistCourses(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            child: controller.isWishListDataLoading
                ? const LoadingIndicator()
                : controller.myWishList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(Images.emptyWishlistIcon,scale: 3,),
                            const SizedBox(height: Dimensions.paddingSizeSmall,),
                            Text(
                            'no_favourites'.tr,
                            style: robotoSemiBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                            ),),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                            Text(
                              'you_have_not_liked_any_items_yet'.tr,
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodySmall!.color,
                              ),),
                          ],
                        ))
                    : mainUI(context, controller),
          );
        });
  }

  ListView mainUI(BuildContext context, WishListController controller) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.myWishList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeExtraSmall),
            child: item(context, controller.myWishList[index]),
          );
        });
  }

  Widget item(BuildContext context, Course course) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Get.toNamed(
            RouteHelper.getCourseDetailsScreenRoute(),
            arguments: course.id);
      },
      child: Container(
        width: width / 1.2,
        height: 110,
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width / 1.8,
                          child: Text(
                            course.title ?? "",
                            maxLines: 2,
                            style: robotoMedium.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: Dimensions.paddingSizeRadius),
                          child: InkWell(
                            onTap: () => Get.find<WishListController>()
                                .removeFromWishList(course.id!, 'course'),
                            child: SvgPicture.asset(
                              Images.delete,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.6),
                            ),
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
