import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_text_field.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/course_detail_controller.dart';
import 'package:lms_user_app/feature/courseDetails/widgets/review_view.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../components/custom_button.dart';

class CourseReview extends StatelessWidget {
  final int totalReview;
  final String avgRatings;
  final bool isReviewed;
  final bool isCanReview;
  final int courseId;
  const CourseReview(
      {Key? key,
      required this.totalReview,
      required this.avgRatings,
      required this.isReviewed,
      required this.isCanReview,
      required this.courseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'course_review'.tr,
                style: robotoSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyLarge!.color!),
              ),
              isCanReview == false
                  ? const SizedBox()
                  : InkWell(
                      onTap: () => showWriteReviewDialog(context),
                      radius: Dimensions.radiusSmall,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.06),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radiusSmall),
                            bottomLeft: Radius.circular(Dimensions.radiusSmall),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeRadius),
                          child: Text(
                            'write_review'.tr,
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SizedBox(
            //height: 78,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.06),
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      avgRatings,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    RatingBar.builder(
                      initialRating: double.parse(avgRatings),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemSize: 15,
                      itemBuilder: (context, _) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        //print(rating);
                      },
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(
                      "($totalReview Review)",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.5),
                          fontSize: Dimensions.fontSizeExtraSmall),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //review(context),
        ReviewView(id: courseId)
      ],
    );
  }

  Padding review(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.06)),
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeSmall),
                    child: CircleAvatar(
                      radius: 20,
                      child: ClipOval(child: Image.asset(Images.demoProfile)),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hellio Jamsh",
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!,
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 12,
                              width: 72,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeMint),
                                      child: SvgPicture.asset(Images.starFill),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        Text("Student  |  21 Jan 2023",
                            style: robotoRegular.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(0.6),
                                fontSize: Dimensions.fontSizeExtraSmall)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                "English course designed to teach kids how to speak English in real life situations.",
                style: robotoMedium.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.6),
                    fontSize: Dimensions.fontSizeSmall),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showWriteReviewDialog(BuildContext context) {
    return Get.dialog(GetBuilder<CourseDetailController>(
        id: '_dialog',
        builder: (controller) {
          return SimpleDialog(
            surfaceTintColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
            insetPadding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "write_review".tr,
                        style: robotoSemiBold,
                      ),
                    ),
                    Divider(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.06),
                    ),
                    Text(
                      "rating".tr,
                      style: robotoMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: Dimensions.paddingSizeDefault),
                      child: RatingBar.builder(
                        initialRating: double.parse(avgRatings),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: false,
                        itemCount: 5,
                        itemSize: 15,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          controller.updateRating(rating);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeDefault,
                          top: Dimensions.paddingSizeLarge),
                      child: Text(
                        "review".tr,
                        style: robotoMedium,
                      ),
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.06),
                        ),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Dimensions.paddingSizeExtraSmall)),
                      ),
                      child: CustomTextField(
                        hintText: 'write_something'.tr,
                        controller: controller.reviewTextController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: Dimensions.paddingSizeLarge),
                      child: controller.isReviewPosting == true
                          ? const LoadingIndicator()
                          : CustomButton(
                              buttonText: 'post_review'.tr,
                              onPressed: () async {
                                await controller.postReview(id: courseId);
                              }),
                    ),
                  ],
                ),
              )
            ],
          );
        }));
  }
}
