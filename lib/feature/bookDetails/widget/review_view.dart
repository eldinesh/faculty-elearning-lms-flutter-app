import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/book_detail_controller.dart';

import '../../../data/model/user_review/review.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';

class ReviewView extends StatelessWidget {
  final int id;
  const ReviewView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookDetailController>(
        initState: (state) => Get.put(BookDetailController()).getReviews(id),
        builder: (controller) {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.reviews.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return reviewItem(context, controller.reviews[index]);
                },
              ),
              if (controller.isLoadingReviewsMore == true)
                const LoadingIndicator(),
              if (controller.isLoadingReviewsMore == false &&
                  controller.hasMoreReviewData == true)
                moreButton(context)
            ],
          );
        });
  }

  Container moreButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radiusSmall),
          bottomLeft: Radius.circular(Dimensions.radiusSmall),
        ),
      ),
      child: InkWell(
        onTap: () => Get.put(BookDetailController()).paginateReviews(id),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall,
              vertical: Dimensions.paddingSizeRadius),
          child: Text(
            'show_more'.tr,
            style: robotoRegular.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.6),
                fontSize: Dimensions.fontSizeSmall),
          ),
        ),
      ),
    );
  }

  Widget reviewItem(BuildContext context, Review review) {
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
                  .withOpacity(0.06),
              width: 1),
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeSmall),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        imageUrl: review.user?.image ?? '',
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        placeholder: (context, url) =>
                            Image.asset(Images.placeholder),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
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
                              review.user?.name ?? '',
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
                              width: 77,
                              child: RatingBar.builder(
                                initialRating:
                                    double.parse(review.rating ?? "0.0"),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemSize: 12,
                                itemBuilder: (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {
                                  //print(rating);
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(review.date ?? '',
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
                review.comment ?? '',
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
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
}
